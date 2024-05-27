//
//  MainTabView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct MainTabView: View {
    var coordinator: AppCoordinator
    
    var body: some View {
        TabView {
            NavigationView() {
                let searchCoordinator = coordinator.showSearch()
                SearchView(viewModel: SearchViewModel(coordinator: searchCoordinator))
            }
            .tabItem {
                Image("search")
                    .renderingMode(.template)
                Text("Поиск")
            }
            
            NavigationView() {
                let favoritesCoordinator = coordinator.showFavorites()
                FavoritesView(viewModel: FavoritesViewModel(coordinator: favoritesCoordinator))
            }
            .tabItem {
                Image("favorites")
                    .renderingMode(.template)
                Text("Избранное")
            }
            
            NavigationView() {
                let responsesCoordinator = coordinator.showResponses()
                ResponsesView(viewModel: ResponsesViewModel(coordinator: responsesCoordinator))
            }
            .tabItem {
                Image("responses")
                    .renderingMode(.template)
                Text("Отклики")
            }
            
            NavigationView() {
                let messagesCoordinator = coordinator.showMessages()
                MessagesView(viewModel: MessagesViewModel(coordinator: messagesCoordinator))
            }
            .tabItem {
                Image("messages")
                    .renderingMode(.template)
                Text("Сообщения")
            }
            
            NavigationView() {
                let profileCoordinator = coordinator.showProfile()
                ProfileView(viewModel: ProfileViewModel(coordinator: profileCoordinator))
            }
            .tabItem {
                Image("profile")
                    .renderingMode(.template)
                Text("Профиль")
            }
        }
    }
}
