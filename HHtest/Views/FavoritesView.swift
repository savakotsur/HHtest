//
//  FavoritesView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                HStack {
                    Text(viewModel.favoriteVacancies.count.vacancies())
                        .font(.subheadline)
                        .foregroundColor(Color("gray3"))
                        .padding(.top, 10)
                    Spacer()
                }
                .padding(.horizontal, 20)
                ForEach(viewModel.favoriteVacancies) { vacancy in
                    VacancyBlock(vacancy: vacancy, onSelect: { vacancy in
                        //                        NavigationView() {
                        //                            let vacancyCoordinator = viewModel.coordinator.showVacancy()
                        //                            VacancyView(viewModel: VacancyViewModel(coordinator: vacancyCoordinator, context: viewModel.context, vacancy: vacancy)
                        print("mdai")
                    }, onFavoriteTapped: {
                        viewModel.removeFromFavorites(vacancyID: vacancy.id)
                    })
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
