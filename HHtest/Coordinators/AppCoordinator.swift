//
//  AppCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

class AppCoordinator {
//    var window: UIWindow?
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
    
//    func start() {
//        let tabView = MainTabView(coordinator: self)
//        let hostingController = UIHostingController(rootView: tabView)
//        window?.rootViewController = hostingController
//        window?.makeKeyAndVisible()
//    }
    
    func start() -> some View {
        MainTabView(coordinator: self)
    }
    
    func showSearch() -> SearchCoordinator {
        let searchCoordinator = SearchCoordinator()
        return searchCoordinator
    }
    
    func showFavorites() -> FavoritesCoordinator {
        let favoritesCoordinator = FavoritesCoordinator()
        return favoritesCoordinator
    }
    
    func showResponses() -> ResponsesCoordinator {
        let responsesCoordinator = ResponsesCoordinator()
        return responsesCoordinator
    }
    
    func showMessages() -> MessagesCoordinator {
        let messagesCoordinator = MessagesCoordinator()
        return messagesCoordinator
    }
    
    func showProfile() -> ProfileCoordinator {
        let profileCoordinator = ProfileCoordinator()
        return profileCoordinator
    }
}
