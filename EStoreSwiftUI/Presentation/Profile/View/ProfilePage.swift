//
//  ProfilePage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import SwiftUI

struct ProfilePage: View {
    
    @StateObject var vm: ProfileViewModel
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea(edges:.top)
            
            
            VStack {
                
                Text(vm.userData?.name ?? "Not Set")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 60)
                
                Text(vm.userData?.email ?? "Not Set")
                    .foregroundStyle(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                
                Text(vm.userData?.role ?? "Not Set")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .padding()
                
               
                
                Button(action: {
                    vm.logout()
                }, label: {
                    Text("Logout")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                })
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onChange(of: vm.isLogout) { oldValue, newValue in
                    if newValue {
                        authManager.logout()
                    }
                }
                

                
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            
            VStack {
                Spacer()
                if let imageUrl = URL(string: vm.userData?.avatar ?? "") {
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
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.top, -10)
                }else {
                    Image("dummy_clothes")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .padding(.top, -10)
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            vm.getProfile()
        }
        
        
        
    }
}

#Preview {
    ProfilePage(vm: ProfileViewModel(service: AuthService()))
}
