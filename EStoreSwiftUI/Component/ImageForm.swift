//
//  ImageForm.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 13/04/24.
//

import SwiftUI

struct ImageForm: View {
    
    var deleteAction: ((Int) -> Void)
    var imageUrl: String
    var body: some View {
        ZStack(alignment:.topTrailing) {
            if let imageUrls = URL(string: imageUrl) {
                tempAsyncImage(url: imageUrls)
            }else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
            }
   
            Button(action: {
                deleteAction(1)
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.red)
            })
            .padding(.top, -5)
            .padding(.trailing, -5)
            
        }
    }
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
            Image(systemName: "photo.fill")
                .resizable()
            
        @unknown default:
            EmptyView()
        }
    }
    .scaledToFill()
    .clipShape(RoundedRectangle(cornerRadius: 10))
}

#Preview {
    ImageForm(deleteAction: {_ in 
        
    }, imageUrl: "")
}
