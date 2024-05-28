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
        VStack {
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    HStack {
                        HStack {
                            Image("search")
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                            Text("Должность, ключевые слова")
                                .padding(.leading, 2)
                                .foregroundColor(Color("grayText"))
                                .font(.callout)
                            Spacer()
                        }
                        .frame(maxWidth: screenSize.width / 1.2)
                        .padding(10)
                        .background(Color("graySearch"))
                        .cornerRadius(10)
                        Image("filter")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .padding(10)
                            .background(Color("graySearch"))
                            .cornerRadius(10)
                    }
                    
                    OffersScroll()
                    
                    Text("Вакансии для вас")
                        .font(.title)
                        .fontWeight(.bold)
                    if let homeScreenData = viewModel.homeScreenData {
                        ForEach(homeScreenData.vacancies) {vacancy in
                            VacancyBlock(vacancy: vacancy, viewModel: viewModel)
                                .padding(.vertical, 2)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}
