//
//  AuthenticationCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import Foundation
import SwiftUI

enum AuthenticationPage {
    case login, forgotPassword
}

final class AuthenticationCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    
    private var id: UUID
    private var output: Output?
    private var page: AuthenticationPage
    
    struct Output {
        var goToMainScreen: () -> Void
    }
    
    init(
        page: AuthenticationPage,
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.page = page
        self.output = output
        self._navigationPath = navigationPath
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self.page {
        case .login:
            loginView()
        case .forgotPassword:
            forgotPasswordView()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: AuthenticationCoordinator,
        rhs: AuthenticationCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
    
//    private func loginView() -> some View {
//        let loginView = LoginView(
//            output:
//                    .init(
//                        goToMainScreen: {
//                            self.output?.goToMainScreen()
//                        },
//                        goToForgotPassword:  {
//                            self.push(
//                                AuthenticationCoordinator(
//                                    page: .forgotPassword,
//                                    navigationPath: self.$navigationPath
//                                )
//                            )
//                        }
//                    )
//        )
//        return loginView
//    }
    
//    private func forgotPasswordView() -> some View {
//        let forgotPasswordView = ForgotPasswordView(output:
//                .init(
//                    goToForgotPasswordWebsite: {
//                        self.goToForgotPasswordWebsite()
//                    }
//                )
//        )
//        return forgotPasswordView
//    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
