//
//  PickCategoryPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import SwiftUI

struct PickCategoryPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCategory: CategoryModel?
    var listCategoris = [CategoryModel]()
    var body: some View {
        VStack {
            Text("Select Category")
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top)
            List {
                ForEach(listCategoris, id: \.id) { category in
                    CategoryPickView(category: category)
                        .onTapGesture {
                            selectedCategory = category
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct CategoryPickView: View {
    var category: CategoryModel
    var body: some View {
        HStack {
            if let imageUrl = URL(string: category.image) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                    case .failure:
                        Image("Clothes")
                            .resizable()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 50, height: 50)
            }else{
                Image("Clothes")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Text(category.name)
                .foregroundStyle(.black)
                .font(.title3)
                .lineLimit(1)
        }
    }
}

#Preview {
    PickCategoryPage(selectedCategory: .constant(CategoryModel(id: 1, name: "tes", image: "tes")))
}
