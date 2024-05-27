//
//  FavoritesViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    private var coordinator: FavoritesCoordinator
    
    init(coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }
}
