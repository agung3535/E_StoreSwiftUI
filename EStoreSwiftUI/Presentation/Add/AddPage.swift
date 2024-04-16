//
//  AddPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 15/04/24.
//

import SwiftUI

struct AddPage: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Add Item")
                    .fontWeight(.bold)
                    .padding(.top)
                HStack {
                    Spacer()
                    NavigationLink {
                        CreateProductPage(vm: AddProductViewModel(
                            service: AddProductService(),
                            categoryService: CategoryService()), updateData: {
                                
                            })
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        VStack {
                            Image("Clothes")
                                .resizable()
                                .frame(width: 80, height: 80)
                                
                            Text("Add Product")
                                .foregroundStyle(.black)
                                
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"),lineWidth: 1)
                        )
                    }

                    
                    Spacer()
                    
                    NavigationLink(destination: CreateCategoryPage(vm: AddProductViewModel(service: AddProductService(), categoryService: CategoryService()), categoryVM: CategoryViewModel(categoryService: CategoryService()))) {
                        VStack {
                            Image("List")
                                .resizable()
                                .frame(width: 80, height: 80)
                                
                            Text("Add Category")
                                .foregroundStyle(.black)
                                
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"),lineWidth: 1)
                        )
                    }
                    Spacer()
                }
                .padding(.top, 30)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AddPage()
}
