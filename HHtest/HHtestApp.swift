//
//  HHtestApp.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

let screenSize = UIScreen.main.bounds

@main
struct HHtestApp: App {
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath(), context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.view()
                .navigationDestination(
                    for: AuthenticationCoordinator.self
                ) { coordinator in
                    coordinator.view()
                }
        }
    }
}
