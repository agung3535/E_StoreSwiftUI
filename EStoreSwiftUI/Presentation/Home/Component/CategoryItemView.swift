//
//  CategoryItemView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI


struct CategoryItemView: View {
    var imageName: String = "List"
    var title: String = "All"
    var body: some View {
        VStack {
            Group {
                if let imageUrl = URL(string: imageName){
                    tempAsyncImage(url: imageUrl)
                }else {
                    Image(imageName)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .padding()
                }
            }
            Text(title)
                .frame(width: 80, height: 20)
                .font(.system(size: 12))
                .padding(.horizontal, 10)
                .lineLimit(1)
            Spacer()
        }
        
       
    }
}

#Preview {
    CategoryItemView()
}


@ViewBuilder
private func tempAsyncImage(url: URL) -> some View {
    AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image.resizable()
        case .failure:
            Image("List")
                .resizable()
            
        @unknown default:
            EmptyView()
        }
    }
    .frame(width: 80, height: 80)
    .aspectRatio(contentMode: .fill)
    .clipShape(RoundedRectangle(cornerRadius: 10))

}
