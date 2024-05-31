//
//  MainTabView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct MainTabView: View {
    var coordinator: AppCoordinator
    @StateObject var mainTabViewModel: MainTabViewModel
    
    var body: some View {
        TabView {
            NavigationView() {
                let searchCoordinator = coordinator.showSearch()
                SearchView(viewModel: SearchViewModel(coordinator: searchCoordinator, context: mainTabViewModel.context))
            }
            .tabItem {
                Image("search")
                    .renderingMode(.template)
                Text("Поиск")
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("gray1"), for: .tabBar)
            
            NavigationView() {
                let favoritesCoordinator = coordinator.showFavorites()
                FavoritesView(viewModel: FavoritesViewModel(coordinator: favoritesCoordinator, context: mainTabViewModel.context))
                    .navigationTitle("Избранное")
            }
            .tabItem {
                Image("favorites")
                    .renderingMode(.template)
                Text("Избранное")
            }
            .badge(mainTabViewModel.favoriteVacanciesCount)
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("gray1"), for: .tabBar)
            
            NavigationView() {
                let responsesCoordinator = coordinator.showResponses()
                ResponsesView(viewModel: ResponsesViewModel(coordinator: responsesCoordinator))
            }
            .tabItem {
                Image("responses")
                    .renderingMode(.template)
                Text("Отклики")
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("gray1"), for: .tabBar)
            
            NavigationView() {
                let messagesCoordinator = coordinator.showMessages()
                MessagesView(viewModel: MessagesViewModel(coordinator: messagesCoordinator))
            }
            .tabItem {
                Image("messages")
                    .renderingMode(.template)
                Text("Сообщения")
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("gray1"), for: .tabBar)
            
            NavigationView() {
                let profileCoordinator = coordinator.showProfile()
                ProfileView(viewModel: ProfileViewModel(coordinator: profileCoordinator))
            }
            .tabItem {
                Image("profile")
                    .renderingMode(.template)
                Text("Профиль")
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("gray1"), for: .tabBar)
        }
    }
}
