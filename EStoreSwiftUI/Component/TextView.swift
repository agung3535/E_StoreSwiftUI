//
//  TextView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 13/04/24.
//

import SwiftUI


struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    
    

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    // Coordinator to handle UITextViewDelegate methods
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.text = textView.text
            }
        }
    }
    
    
}
