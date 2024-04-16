//
//  InputFormWithTitle.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 13/04/24.
//

import SwiftUI

struct InputFormWithTitle: View {
    
    @Binding var txtState: String
    var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
            TextField("", text: $txtState)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray,lineWidth: 1)
                )
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    InputFormWithTitle(txtState: .constant(""))
}
