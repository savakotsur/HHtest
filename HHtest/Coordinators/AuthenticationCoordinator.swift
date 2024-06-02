//
//  AuthenticationCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import Foundation
import SwiftUI

final class AuthenticationCoordinator {
    @Binding var isAuthenticated: Bool
    @Binding var approvingEmail: Bool
    @Binding var email: String
    var id = UUID()
    
    init(isAuthenticated: Binding<Bool>, navigationPath: NavigationPath, email: Binding<String>, approvingEmail: Binding<Bool>) {
        self._isAuthenticated = isAuthenticated
        self._email = email
        self._approvingEmail = approvingEmail
    }
    
    @ViewBuilder
    func loginView(approvingEmail: Binding<Bool>, email: Binding<String>) -> some View {
        LoginView(viewModel: LoginViewModel(), approvingEmail: $approvingEmail, email: $email)
            .navigationTitle("Вход в личный кабинет")
    }
    
    @ViewBuilder
    func approveView(isAuthenticated: Binding<Bool>) -> some View {
        EmailApproveView(email: email, isAuthenticated: $isAuthenticated)
    }
    
    func completeAuthentication() {
        isAuthenticated = true
    }
}
