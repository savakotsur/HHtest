//
//  SearchCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import Foundation
import UIKit
import SwiftUI

class SearchCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showVacancyDetail(viewModel: VacancyViewModel) {
        let detailView = VacancyView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController.pushViewController(hostingController, animated: true)
        print("Pushed vacancy")
    }
    
}
