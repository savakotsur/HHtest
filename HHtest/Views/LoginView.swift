//
//  LoginView.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @Binding var approvingEmail: Bool
    @Binding var email: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Вход в личный кабинет")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            VStack (alignment: .leading) {
                Text("Поиск работы")
                    .font(.title3)
                    .fontWeight(.semibold)
                CustomTextField(viewModel: viewModel)
                
                    .background(Color("gray2"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.showError ? Color.red : Color.clear, lineWidth: 2)
                    )
                
                if viewModel.showError {
                    Text("Вы ввели неверный e-mail")
                        .foregroundColor(.red)
                }
                HStack {
                    Button(action: {
                        viewModel.validateEmail()
                        if !viewModel.showError {
                            approvingEmail = true
                            email = viewModel.email
                        }
                    }) {
                        Text("Продолжить")
                            .foregroundColor(Color("white"))
                    }
                    .frame(minWidth: screenSize.width / 2.5, minHeight: screenSize.height / 17)
                    .background(Color("blue"))
                    .cornerRadius(10)
                    Button(action: {
                        print("Войти с паролем")
                    }) {
                        Text("Войти с паролем")
                            .foregroundColor(Color("blue"))
                    }
                    .frame(minWidth: screenSize.width / 2.5, minHeight: screenSize.height / 17)
                }
                .padding(.top, 10)
                
            }
            .padding(20)
            .frame(maxWidth: screenSize.width / 1.1, minHeight: screenSize.height / 5)
            .background(Color("gray1"))
            .cornerRadius(10)
            
            SearchForEmpl()
                .padding(.top, 10)
            Spacer()
        }
        .padding(.horizontal, 10)
        .background(Color("black"))
    }
}
