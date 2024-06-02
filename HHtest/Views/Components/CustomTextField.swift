//
//  CustomTextField.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct CustomTextField: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        HStack {
            if viewModel.email == "" {
                Image("responses")
                    .renderingMode(.template)
                    .foregroundColor(Color("gray3"))
                    .padding(.leading)
                    .padding(.trailing, -10)
            }
            
            TextField("Электронная почта или телефон", text: $viewModel.email)
                .padding()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            
            Button(action: {
                viewModel.email = ""
                viewModel.showError = false
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(viewModel.showError ? Color.red : Color.clear)
            }
            .padding(.trailing)
        }
        .background(viewModel.showError ? Color.red.opacity(0.1) : Color.clear)
    }
}
