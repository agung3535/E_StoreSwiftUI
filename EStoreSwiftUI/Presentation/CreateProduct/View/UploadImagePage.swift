//
//  UploadImagePage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import SwiftUI

struct UploadImagePage: View {
    @State private var productImage = UIImage(systemName: "photo.fill")!
    @StateObject var vm: AddProductViewModel
    @State private var showPhoto: Bool = false
    @State private var photoSource: PhotoSource?
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: productImage)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom)
                    .onTapGesture {
                        self.showPhoto.toggle()
                    }
                
                Button("Upload Image") {
                    vm.uploadImage(image: productImage)
                }
                .disabled(vm.isLoadingUpload)
                .buttonStyle(.borderedProminent)
            }
            .confirmationDialog("Choose your photo source", isPresented: $showPhoto) {
                
                Button("Camera") {
                    self.photoSource = .camera
                }
                
                Button("Photo Library") {
                    self.photoSource = .photoLibrary
                }
            }
            .fullScreenCover(item: $photoSource) { source in
                switch source {
                case .photoLibrary:
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $productImage)
                        .ignoresSafeArea()
                case .camera:
                    ImagePicker(sourceType: .camera, selectedImage: $productImage)
                        .ignoresSafeArea()
                }
            }
            .onChange(of: vm.isImageUploaded, { oldValue, newValue in
                if newValue {
                    presentaionMode.wrappedValue.dismiss()
                }
            })
            .padding()
        }
    }
}

#Preview {
    UploadImagePage(vm: AddProductViewModel(service: AddProductService(), categoryService: CategoryService()))
}
