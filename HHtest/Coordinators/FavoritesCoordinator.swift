//
//  FavoritesCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import Foundation
import SwiftUI
import CoreData

class FavoritesCoordinator {
    @Binding var navigationPath: NavigationPath
    
    init(navigationPath: Binding<NavigationPath>) {
        self._navigationPath = navigationPath
    }
    
    @ViewBuilder
    func view(context: NSManagedObjectContext) -> some View {
        FavoritesView(viewModel: FavoritesViewModel(context: context, path: self.$navigationPath))
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
