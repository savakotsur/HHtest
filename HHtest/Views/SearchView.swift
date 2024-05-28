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
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            Group {
                                VStack (alignment: .leading) {
                                    Image("vacancies1")
                                        .resizable()
                                        .frame(width: 30.0, height: 30.0)
                                        .padding(4)
                                        .background(Color("blueElements"))
                                        .cornerRadius(100)
                                    Text("Вакансии рядом с вами")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: screenSize.width / 2.4, minHeight: screenSize.height / 6.5)
                                .background(Color("grayMain"))
                                .cornerRadius(10)
                            }
                            Group {
                                VStack (alignment: .leading) {
                                    Image("star")
                                        .resizable()
                                        .frame(width: 30.0, height: 30.0)
                                        .padding(4)
                                        .background(Color("greenElements"))
                                        .cornerRadius(100)
                                    Text("Поднять резюме в поиске")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                    Text("Поднять")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("greenMain"))
                                }
                                .frame(maxWidth: screenSize.width / 2.4, minHeight: screenSize.height / 6.5)
                                .background(Color("grayMain"))
                                .cornerRadius(10)
                            }
                            Group {
                                VStack (alignment: .leading) {
                                    Image("vacancies2")
                                        .resizable()
                                        .frame(width: 30.0, height: 30.0)
                                        .padding(4)
                                        .background(Color("greenElements"))
                                        .cornerRadius(100)
                                    Text("Временная работа или подработка")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: screenSize.width / 2.4, minHeight: screenSize.height / 6.5)
                                .background(Color("grayMain"))
                                .cornerRadius(10)
                            }
                        }
                    }.padding(.vertical, 8)
                    
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
