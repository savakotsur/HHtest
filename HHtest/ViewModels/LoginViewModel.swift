//
//  LoginViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = "" {
        didSet {
            emailChanged()
        }
    }
    @Published var showError: Bool = false
    
    func validateEmail() {
            let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            showError = !emailPredicate.evaluate(with: email)
        }
    
    func emailChanged() {
        showError = false
    }
}
