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
            GeometryReader { geometry in
                Color.clear.frame(height: geometry.safeAreaInsets.top)
            }
            .frame(height: 0)
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    HStack {
                        HStack {
                            Image("search")
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                            Text("Должность, ключевые слова")
                                .padding(.leading, 2)
                                .foregroundColor(Color("gray3"))
                                .font(.callout)
                            Spacer()
                        }
                        .frame(maxWidth: screenSize.width / 1.2)
                        .padding(10)
                        .background(Color("gray2"))
                        .cornerRadius(10)
                        Image("filter")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .padding(10)
                            .background(Color("gray2"))
                            .cornerRadius(10)
                    }
                    
                    OffersScroll()
                    
                    Text("Вакансии для вас")
                        .font(.title)
                        .fontWeight(.bold)
                    if let homeScreenData = viewModel.homeScreenData {
                        ForEach(homeScreenData.vacancies.prefix(3)) {vacancy in
                            VacancyBlock(vacancy: vacancy, viewModel: viewModel)
                                .padding(.vertical, 2)
                        }
                        Button(action: {
                            print("Кнопка отображения вакансий нажата")
                        })
                        {
                            Text("Еще " + homeScreenData.vacancies.count.vacancies())
                                .foregroundColor(Color("white"))
                        }
                        .frame(maxWidth: .infinity, minHeight: screenSize.height / 18)
                        .background(Color("blue"))
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal, 10)
            }
            .background(Color("black").edgesIgnoringSafeArea(.top))
        }
    }
}
