//
//  SearchCoordinator.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI
import CoreData

class VacancyCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    var vacancy: Vacancy
    private var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: VacancyCoordinator, rhs: VacancyCoordinator) -> Bool {
        lhs.id == rhs.id
    }

    init(navigationPath: Binding<NavigationPath>, vacancy: Vacancy) {
        self._navigationPath = navigationPath
        self.vacancy = vacancy
    }
    
    @ViewBuilder
    func view(context: NSManagedObjectContext, vacancy: Vacancy) -> some View {
        VacancyView(viewModel: VacancyViewModel(context: context, vacancy: vacancy))
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
