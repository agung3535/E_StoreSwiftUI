//
//  CreateCategoryPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import SwiftUI

struct CreateCategoryPage: View {
    
    @State var categoryName: String = ""
    @State var pickPhoto: Bool = false
    @StateObject var vm: AddProductViewModel
    @StateObject var categoryVM: CategoryViewModel
    @State var isEdit: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                if !vm.uploadedImage.isEmpty {
                    if let imgUrl = URL(string: vm.uploadedImage.first ?? "") {
                        ZStack(alignment:.topTrailing) {
                            AsyncImage(url: imgUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                case .failure:
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 50, height: 50)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading)
                            .padding(.top, 5)
                           
                            
                            Button(action: {
                                vm.uploadedImage.remove(at: 0)
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            })
                            .padding(.top, -5)
                            .padding(.trailing, -5)
                        }
                    }
                }else {
                    Button(action: {
                        pickPhoto.toggle()
                    }, label: {
                       
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                        
                    })
                    .disabled(!vm.uploadedImage.isEmpty)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainColor"), lineWidth: 1)
                    )
                    .padding(.leading, 20)
                    .fullScreenCover(isPresented: $pickPhoto, content: {
                        UploadImagePage(vm: vm)
                    })
                    
                    
                }
                
                TextField("Category Name", text: $categoryName)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray,lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .padding(.top)
                
            Button(action: {
                if isEdit {
                    categoryVM.updateCategories(id: categoryVM.oldCategories?.id ?? 0, name: categoryName, images: vm.uploadedImage.first)
                }else {
                    categoryVM.addCategory(name: categoryName, image: vm.uploadedImage.first ?? "")
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
            
            Text("Category List")
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .padding()
            
            List {
                ForEach(categoryVM.categoryList, id: \.id) { category in
                    HStack {
                        if let imageUrl = URL(string: category.image) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                case .failure:
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 40, height: 40)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading)
                            .padding(.top, 5)
                        }else {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding()
                        }
                        
                        Text(category.name)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive, action: {
                            categoryVM.deleteCategories(id: category.id)
                        } ) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            self.categoryName = category.name
                            vm.uploadedImage.append(category.image)
                            self.isEdit = true
                            categoryVM.oldCategories = category
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.green)
                        
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
        }
        .onAppear {
            categoryVM.fetchCategories()
        }
        .onChange(of: categoryVM.isUpdateCategoriesSuccess, { oldValue, newValue in
            if newValue {
                categoryVM.fetchCategories()
            }
        })
        .navigationTitle("Add New Category")
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CreateCategoryPage(vm: AddProductViewModel(service: AddProductService(), categoryService: CategoryService()), categoryVM: CategoryViewModel(categoryService: CategoryService()))
}
