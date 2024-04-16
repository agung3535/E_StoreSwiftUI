//
//  CreateProductPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct CreateProductPage: View {
    
    @State private var productName: String = ""
    @State private var price: String = ""
    @State private var desc: String = ""

    @State private var pickPhoto: Bool = false
    
    @State private var showCategory: Bool = false
    
    @State private var selectedCategory: CategoryModel?
    
    @State private var productImage = UIImage(systemName: "plus")!
    
    @ObservedObject var vm: AddProductViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var product: ProductModel?
    
    var updateData: (() -> Void)
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                InputFormWithTitle(
                    txtState: $productName,
                    title: "Product Name"
                )
                .padding(.top, 10)
                
                InputFormWithTitle(
                    txtState: $price,
                    title: "Price"
                )
                .padding(.top, 10)
                
                Text("Add Image")
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(Array(vm.uploadedImage.enumerated()), id: \.offset) { index, data in
                            ImageForm(deleteAction: { id in
                                vm.uploadedImage.remove(at: index)
                            }, imageUrl: data)
                                .padding(.leading, 30)
                                .frame(width: 80, height: 80)
                                .padding()
                        }
                        
                        
                        Button(action: {
                            pickPhoto.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding()
                        })
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                        .fullScreenCover(isPresented: $pickPhoto, content: {
                            UploadImagePage(vm: vm)
                        })
                        
                    }
                    .frame(height: 100)
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 20)
                    TextView(text: $desc)
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray,lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                }
                
                VStack(alignment: .leading) {
                    Text("Category")
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 20)
                    if selectedCategory != nil {
                        Text(selectedCategory?.name ?? "")
                            .foregroundStyle(.gray)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray,lineWidth: 1)
                            )
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                showCategory.toggle()
                            }
                    }else {
                        Text("Pick Category")
                            .foregroundStyle(.gray)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray,lineWidth: 1)
                            )
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                showCategory.toggle()
                            }
                    }
                   
                }
               
                .sheet(isPresented: $showCategory, content: {
                    PickCategoryPage(selectedCategory: $selectedCategory,
                     listCategoris: vm.categoryList)
                })
                
                Button(action: {
                    if product == nil {
                        vm.createProduct(title: productName, price: Int(price) ?? 0, desc: desc, category: selectedCategory?.id ?? 0, images: vm.uploadedImage)
                    }else {
                        vm.updateProduct(id: product!.id, title: productName, price: Int(price) ?? 0, desc: desc, category: selectedCategory?.id ?? 0, images: vm.uploadedImage)
                    }
                   
                }, label: {
                    Text("Save")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        .padding()
                })
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color("MainColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onChange(of: vm.isPostProductSuccess) { oldValue, newValue in
                    if newValue {
                        updateData()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                Spacer()
            }
            
        }.onAppear {
            if product != nil,
                let pTitle = product?.title,
               let pPrice = product?.price,
               let pDesc = product?.description,
               let pCategory = product?.category,
               let pImages = product?.images
            {
                productName = pTitle
                price = String(pPrice)
                desc = pDesc
                selectedCategory = CategoryModel(id: pCategory.id, name: pCategory.name, image: pCategory.image)
                vm.uploadedImage = pImages
                vm.oldProduct = product
            }
            vm.fetchCategories()
        }
    }
}

//struct

#Preview {
    CreateProductPage(vm: AddProductViewModel(
        service: AddProductService(), categoryService: CategoryService()), updateData: {
            
        })
}
