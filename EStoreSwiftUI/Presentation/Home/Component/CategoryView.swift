//
//  CategoryView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct CategoryView: View {
    var list: [CategoryModel] = []
    @Binding var selectedCat: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .padding(.leading)
                .padding(.top, 5)
                .fontWeight(.bold)
            ScrollView(.horizontal) {
                LazyHStack(spacing:10) {
                    ForEach(list, id: \.id) { data in
                        CategoryItemView(
                            imageName: data.image,
                            title: data.name
                        )
                       
                        .onTapGesture {
                            self.selectedCat = data.id
                        }
                        .frame(width: 80, height: 120)
                        .background(selectedCat == data.id ? Color("MainColor") : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"), lineWidth: 1)
                        )
                        
                        
                        
                    }
                }
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .scrollIndicators(.hidden)
            .frame(height: 150)
        
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    CategoryView(selectedCat: .constant(-1))
}
