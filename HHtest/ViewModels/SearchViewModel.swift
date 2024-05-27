//
//  SearchViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    private var coordinator: SearchCoordinator
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
    }
}
