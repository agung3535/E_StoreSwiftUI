//
//  CategoryViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import UIKit

@MainActor
class CategoryViewModel: ObservableObject {
    
    
    @Published var uploadedImage = [String]()
    @Published var isLoadingUpload = false
    @Published var isImageUploaded = false
    @Published var isLoadingAddCategory = false
    @Published var isLoadCategoriesFailed = false
    @Published var category: CategoryModel?
    @Published var isLoadingPostProduct = false
    @Published var isPostCategorySuccess = false
    @Published var isPostCategoryFailed = false
    @Published var categoryList: [CategoryModel] = []
    @Published var isLoadCategories = false
    @Published var isLoadingDelete = false
    @Published var deleteCategoriesSuccess = false
    @Published var deleteCategoriesFail = false
    @Published var oldCategories: CategoryModel?
    @Published var isUpdateCategoriesSuccess = false
    @Published var isUpdateCategoriesFail = false

   
    
    private let categoryService: CategoryServiceProtocol
    
    init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }
    
    func addCategory(name: String, image: String) {
        isPostCategoryFailed = false
        if image.isEmpty {
            isPostCategoryFailed = true
        }
        isLoadingAddCategory = true
        Task {
            do {
                category = try await categoryService.createCategory(name: name, image: image)
                isLoadingAddCategory = false
                isPostCategorySuccess = true
            }catch {
                isLoadingAddCategory = false
                isPostCategoryFailed = true
                print("error add category = \(error)")
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
    
    func deleteCategories(id: Int) {
        isLoadingDelete = true
        Task {
            do {
                deleteCategoriesSuccess = try await categoryService.deleteCategory(id: id)
                isLoadingDelete = false
            }catch {
                isLoadingDelete = false
                deleteCategoriesFail = true
                print("Error: \(error)")
            }
        }
    }
    
    func updateCategories(id: Int, name: String?, images: String?) {
        
        let newName = oldCategories?.name == name ? nil : name
        let newImage = oldCategories?.image == images ? nil : images
        
        Task {
            do {
                let result = try await categoryService.updateCategory(id: id, name: newName, image: newImage)
                
                if result != nil {
                    isUpdateCategoriesSuccess = true
                }else{
                    isUpdateCategoriesFail = true
                }
            }catch {
                print("error update = \(error)")
            }
        }
        
    }
    
}
