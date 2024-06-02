//
//  AppCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI
import CoreData

class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    @Published var context: NSManagedObjectContext
    
    init(path: NavigationPath, context: NSManagedObjectContext) {
        self.path = path
        self.context = context
    }
    
    @ViewBuilder
    func view() -> some View {
        MainTabView(mainTabViewModel: MainTabViewModel(context: self.context), appCoordinator: self)
    }
    
}
