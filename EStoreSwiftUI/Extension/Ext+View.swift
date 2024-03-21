//
//  Ext+View.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
}
