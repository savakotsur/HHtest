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
    
    var body: some Scene {
        WindowGroup {
            let appCoordinator = AppCoordinator()
            appCoordinator.start()
        }
    }
}
