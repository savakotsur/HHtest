//
//  MainTabView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var appCoordinator: AppCoordinator
    @StateObject var mainTabViewModel: MainTabViewModel
    
    var body: some View {
        TabView {
            NavigationStack(path: $appCoordinator.path) {
                SearchCoordinator(navigationPath: $appCoordinator.path).view(context: mainTabViewModel.context)
            }
                .tabItem {
                    Image("search")
                        .renderingMode(.template)
                    Text("Поиск")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color("gray1"), for: .tabBar)
            
            NavigationStack(path: $appCoordinator.path) {
                FavoritesCoordinator(navigationPath: $appCoordinator.path).view(context: mainTabViewModel.context)
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
                ResponsesView(viewModel: ResponsesViewModel())
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
                MessagesView(viewModel: MessagesViewModel())
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
                ProfileView(viewModel: ProfileViewModel())
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
        .preferredColorScheme(.dark)
    }
}
