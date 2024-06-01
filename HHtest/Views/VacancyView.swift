//
//  VacancyView.swift
//  HHtest
//
//  Created by Савелий Коцур on 31.05.2024.
//

import SwiftUI

struct VacancyView: View {
    @StateObject var viewModel: VacancyViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                Text(viewModel.vacancy.salary.full)
                    .padding(.bottom, 5)
                Text("Требуемый опыт: " + viewModel.vacancy.experience.text)
                    .padding(.bottom, 2)
                Text(viewModel.schedulesText())
                if viewModel.vacancy.appliedNumber != 0 || viewModel.vacancy.lookingNumber != 0 {
                    VacancyScroll(vacancy: viewModel.vacancy)
                        .padding(.bottom, 5)
                }
                VacancyMapBlock(vacancy: viewModel.vacancy)
                    .padding(.bottom, 3)
                if let vacancyDescription = viewModel.vacancy.vacancyDescription {
                    Text(vacancyDescription)
                }
                VacancyTextResponsibilities(responsibilities: viewModel.vacancy.responsibilities)
                ForEach(viewModel.vacancy.questions, id:\.self) { question in
                    VStack (alignment: .leading) {
                        Text(question)
                            .frame(minWidth: screenSize.width / 4, maxHeight: screenSize.height / 15, alignment: .leading)
                            .padding(13)
                            .background(Color("gray2"))
                            .cornerRadius(100)
                    }
                }
                ResponseButton()
            }
            .navigationTitle(viewModel.vacancy.title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image("backbutton")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarActions(isFavorite: viewModel.vacancy.isFavorite, removeFromFavorites: {
                        viewModel.removeFromFavorites(vacancyID: viewModel.vacancy.id)
                        viewModel.vacancy.isFavorite.toggle()
                    }, saveToCoreData: {
                        viewModel.saveToCoreData(vacancy: viewModel.vacancy)
                        viewModel.vacancy.isFavorite.toggle()
                    })
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 5)
        }
    }
}
