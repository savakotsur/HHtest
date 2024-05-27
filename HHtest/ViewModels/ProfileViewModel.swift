//
//  ProfileViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private var coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
}
