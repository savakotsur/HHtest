//
//  VacancyTextResponsibilities.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI

struct VacancyTextResponsibilities: View {
    let responsibilities: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ваши задачи")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 15)
            Text(responsibilities)
                .padding(.bottom, 20)
            Text("Задайте впорос работодателю")
                .fontWeight(.semibold)
            Text("Он получит его с откликом на вакансию")
                .foregroundColor(Color("gray3"))
        }
    }
}
