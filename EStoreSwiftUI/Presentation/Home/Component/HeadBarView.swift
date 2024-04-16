//
//  HeadBarView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct HeadBarView: View {
    @Binding var searchItem: String
    @Binding var minPrice: String
    @State var showFilter: Bool = false
    @StateObject var vm: HomeViewModel
    @Binding var category: Int
    
    var body: some View {
        HStack {
            TextField(text: $searchItem) {
                Text("Search Product Name")
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            .autocorrectionDisabled()
            .onSubmit {
                vm.fetchProductByFilter(name: searchItem, price: minPrice, category: category)
            }
            
            Button(action: {
                showFilter.toggle()
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
            })
            .padding(.trailing)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("MainColor"))
        .sheet(isPresented: $showFilter, content: {
            FilterView(price: $minPrice, isShow: $showFilter, isAppplyFilter: {
                vm.fetchProductByFilter(name: searchItem, price: minPrice, category: category)
            })
        })
    }
}

struct FilterView: View {
    @Binding var price: String
    @Binding var isShow: Bool
    var isAppplyFilter: (() -> Void)
    var body: some View {
        VStack {
            
            Text("Filter")
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.top)
            
            HStack {
                TextField(text: $price) {
                    Text("Input Price")
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray,lineWidth: 1))
                .padding()
            }
            
            Button(action: {
                isShow = false
                isAppplyFilter()
            }, label: {
                Text("Apply")
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    .padding()
            })

            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color("MainColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            Spacer()
        }
        .presentationDetents([.height(250)])
        
    }
}


#Preview {
    HeadBarView(searchItem: .constant(""), minPrice: .constant(""),vm: HomeViewModel(homeService: HomeService(), categoryService: CategoryService()), category: .constant(0))
}
