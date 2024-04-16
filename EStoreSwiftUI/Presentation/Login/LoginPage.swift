//
//  LoginPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @EnvironmentObject var authManager: AuthManager
    @StateObject var vm: LoginViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("MainColor"),Color("SecondMainColor")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("loginlogo")
                    .resizable()
                    .frame(height: 300)
                    .padding(.top, 50)
                    .scaledToFit()
                VStack {
                    Text("Welcome")
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        .padding(EdgeInsets(top: 40, leading: 30, bottom: 0, trailing: 0))
                    
                    TextField(text: $email) {
                        Text("Email")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(.gray,lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 10,
                                style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(.gray,lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .textInputAutocapitalization(.never)

                    Button(action: {
                        vm.login(email: email, password: password)
                    }, label: {
                        Text("Login")
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                    })
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .fontWeight(.bold)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top)
                    .padding(.horizontal, 30)
                    .onChange(of: vm.isLoginSuccess, { oldValue, newValue in
                        if newValue {
                            authManager.login()
                        }
                    })
                    .navigationDestination(isPresented: $vm.isLoginSuccess) {
                        MainPage()
                    }
                    
                    
                    HStack{
                        Text("Don't have an account?")
                        NavigationLink(
                            destination: RegisterPage(
                                vm: RegisterViewModel(authService: AuthService())
                            )
                                .navigationBarBackButtonHidden(true)
                        ) {
                            Text("Register Here")
                                .fontWeight(.bold)
                        }
                        
                    }
                    .padding(.top)
                    
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight:.infinity)
                .background(.white)
                .cornerRadius(15, corners: .topLeft)
                .cornerRadius(15, corners: .topRight)
                .onChange(of: vm.isLoginFailed, { oldValue, newValue in
                    if newValue {
                        showAlert.toggle()
                    }
                })
                .alert("Gagal Login", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        showAlert = false
                    }
                } message: {
                    Text("Incorrect email or password")
                }

            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginPage(vm: LoginViewModel(authService: AuthService()))
}
