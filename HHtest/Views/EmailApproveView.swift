//
//  EmailApproveView.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct EmailApproveView: View {
    var email: String
    @State private var code: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedField: Int?
    @Binding var isAuthenticated: Bool
    private var isButtonDisabled: Bool {
            return code.contains { $0.isEmpty }
        }

    var body: some View {
        VStack (alignment: .leading) {
            Text("Отправили код на \(email)")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
            Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
            HStack(alignment: .center) {
                Spacer()
                CodeInputView(code: $code)
                Spacer()
            }
            Button(action: {
                isAuthenticated = true
            })
            {
                Text("Подтвердить")
                    .foregroundColor(Color("white"))
            }
            .frame(maxWidth: .infinity, minHeight: screenSize.height / 18)
            .background(isButtonDisabled ? Color("darkBlue") : Color("blue"))
            .cornerRadius(10)
            .padding(.vertical, 10)
            .disabled(isButtonDisabled)
        }
        .frame(maxWidth: .infinity, minHeight: screenSize.height / 1.3)
        .padding(20)
    }
}
