//
//  FavoritesView.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    @State var selectedVacancy: Vacancy?
    
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
                ForEach(viewModel.favoriteVacancies) { myVacancy in
                    VacancyBlock(vacancy: myVacancy, onSelect: { vacancy in
                        selectedVacancy = myVacancy
                        viewModel.didSelectVacancy(myVacancy)
                    }, onFavoriteTapped: {
                        viewModel.removeFromFavorites(vacancyID: myVacancy.id)
                    })
                }
                .navigationDestination(for: VacancyCoordinator.self) { coordinator in
                    if let vacancy = selectedVacancy {
                        coordinator.view(context: viewModel.context, vacancy: vacancy)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
