//
//  RegisterPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI

struct RegisterPage: View {
    
    @StateObject var vm: RegisterViewModel
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("purple_1")
                    .ignoresSafeArea()
                VStack {
                    Image("RegisterEstore")
                        .resizable()
                        .frame(height: 300)
                        .padding(.top, 50)
                        .scaledToFill()
                    VStack {
                        Text("Let's open your store")
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                            .padding(EdgeInsets(top: 40, leading: 30, bottom: 0, trailing: 0))
                        
                        TextField(text: $email) {
                            Text("Email")
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray,lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                        
                        TextField(text: $name) {
                            Text("Name")
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray,lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                        
                        TextField(text: $password) {
                            Text("Password")
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray,lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                        
                        Button(action: {
                            vm.register(name: name, email: email, password: password)
                        }, label: {
                            Text("Create")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top)
                        .padding(.horizontal, 30)
                        .onChange(of: vm.isRegistered) { oldValue, newValue in
                            if newValue {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                        HStack{
                            Text("Already have an account?")
//                            NavigationLink(destination: LoginPage(vm: LoginViewModel(authService: AuthService()))) {
//
//                            }
                            Text("Login")
                                .fontWeight(.bold)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                        .padding(.top)
                        
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight:.infinity)
                    .background(.white)
                    .cornerRadius(15, corners: .topLeft)
                    .cornerRadius(15, corners: .topRight)
                }
                .ignoresSafeArea()
                
            }
        }
    }
}

#Preview {
    RegisterPage(vm: RegisterViewModel(authService: AuthService()))
}
