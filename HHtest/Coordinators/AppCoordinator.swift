//
//  AppCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

class AppCoordinator {
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    
    func start() -> some View {
        MainTabView(coordinator: self, mainTabViewModel: MainTabViewModel(context: PersistenceController.shared.container.viewContext))
            .preferredColorScheme(.dark)
    }
    
    func showSearch() -> SearchCoordinator {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
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
