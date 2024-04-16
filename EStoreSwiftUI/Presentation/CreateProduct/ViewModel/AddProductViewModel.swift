//
//  AddProductViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import UIKit

@MainActor
class AddProductViewModel: ObservableObject {
    
    @Published var uploadedImage = [String]()
    @Published var isLoadingUpload = false
    @Published var isImageUploaded = false
    @Published var isLoadCategories = false
    @Published var isLoadCategoriesFailed = false
    @Published var categoryList: [CategoryModel] = []
    @Published var isLoadingPostProduct = false
    @Published var isPostProductSuccess = false
    @Published var isPostProductFailed = false
    @Published var oldProduct: ProductModel?
    
    private let service: AddProductServiceProtocol
    
    private let categoryService: CategoryServiceProtocol
    
    init(service: AddProductServiceProtocol, categoryService: CategoryServiceProtocol) {
        self.service = service
        self.categoryService = categoryService
    }
    
    
    func uploadImage(image: UIImage) {
        isLoadingUpload = true
        isImageUploaded = false
        Task {
            do {
                let image = try await service.uploadImage(image: image)
                if !image.isEmpty {
                    uploadedImage.append(image)
                }
                isLoadingUpload = false
                isImageUploaded = true
            }catch {
                isLoadingUpload = false
                print("error upload = \(error)")
            }
        }
    }
    
    func fetchCategories() {
        isLoadCategories = true
        Task {
            do {
                categoryList = try await categoryService.fetchAllCategory()
                isLoadCategories = false
            }catch {
                isLoadCategoriesFailed = true
            }
        }
    }
    
    
    func createProduct(title: String, price: Int, desc: String, category: Int, images: [String]) {
        isLoadingPostProduct = true
        Task {
            do {
                let result = try await service.createProduct(title: title, price: price, desc: desc, categoryId: category, images: images)
                if result != nil {
                    isPostProductSuccess = true
                }else {
                    isPostProductFailed = true
                }
                isLoadingPostProduct = false
            }catch {
                isPostProductFailed = true
                isLoadingPostProduct = false
            }
        }
    }
    
    func updateProduct(id: Int, title: String?, price: Int?, desc: String?, category: Int?, images: [String]?) {
        isLoadingPostProduct = true
        
        let newTitle = oldProduct?.title == title ? nil : title
        let newPrice = oldProduct?.price == price ? nil : price
        let newDesc = oldProduct?.description == desc ? nil : desc
        let newCategory = oldProduct?.category.id == category ? nil : category
        
        let newImagesArr = uploadedImage + (images ?? [])
        
        var occurrences: [String: Int] = [String:Int]()
        for element in newImagesArr {
            if let count = occurrences[element] {
              occurrences[element] = count + 1
            }else {
              occurrences[element] = 1
            }
        }
      
        let uniqueArray = newImagesArr.filter { occurrences[$0, default: 0] == 1 }
        
        
        Task {
            do {
                let result = try await service.updateProduct(
                    id: id,
                    title: newTitle,
                    price: newPrice,
                    desc: newDesc,
                    categoryId: newCategory,
                    images: uniqueArray.isEmpty ? nil : uniqueArray
                )
                if result != nil {
                    isPostProductSuccess = true
                }else {
                    isPostProductFailed = true
                }
                isLoadingPostProduct = false
            }catch {
                isPostProductFailed = true
                isLoadingPostProduct = false
            }
        }
    }
    
    
}
