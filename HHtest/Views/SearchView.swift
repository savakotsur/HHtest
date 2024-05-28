//
//  SearchView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            if let homeScreenData = viewModel.homeScreenData {
                ForEach(homeScreenData.vacancies) {vacancy in
                    VacancyBlock(vacancy: vacancy, viewModel: viewModel)
                }
            }
        }
    }
}
