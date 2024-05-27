//
//  AppCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

class AppCoordinator {
    
    func start() -> some View {
        MainTabView(coordinator: self)
            .preferredColorScheme(.dark)
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
