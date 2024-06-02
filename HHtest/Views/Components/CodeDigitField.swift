//
//  SwiftUIView.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct CodeDigitField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    var nextField: () -> Void
    
    var body: some View {
        TextField("", text: $text)
            .frame(width: 60, height: 60)
            .font(.title)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .background(Color("gray1"))
            .cornerRadius(8)
            .focused($isFocused)
            .onChange(of: text) { newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
                text = text.filter { "0123456789".contains($0) }
                if !text.isEmpty {
                    nextField()
                }
            }
    }
}
