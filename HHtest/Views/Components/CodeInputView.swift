//
//  CodeInputView.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct CodeInputView: View {
    @Binding var code: [String]
    @FocusState private var focusedField: Int?

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ForEach(0..<4, id: \.self) { index in
                CodeDigitField(text: $code[index], nextField: {
                    if index < 3 {
                        focusedField = index + 1
                    }
                })
                .focused($focusedField, equals: index)
            }
        }
        .onAppear {
            focusedField = 0
        }
        .padding()
    }
}
