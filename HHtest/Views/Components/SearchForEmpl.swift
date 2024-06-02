//
//  SearchForEmpl.swift
//  HHtest
//
//  Created by Савелий Коцур on 02.06.2024.
//

import SwiftUI

struct SearchForEmpl: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Поиск сотрудников")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Размещение вакансий и доступ к базе резюме")
                .font(.callout)
                .padding(.vertical, 10)
            Button(action: {
                print("Ищу сотрудников")
            })
            {
                Text("Я ищу сотрудников")
                    .foregroundColor(Color("white"))
            }
            .frame(maxWidth: .infinity, minHeight: screenSize.height / 20)
            .background(Color("green"))
            .cornerRadius(100)
        }
        .padding(20)
        .frame(maxWidth: screenSize.width / 1.1, minHeight: screenSize.height / 5)
        .background(Color("gray1"))
        .cornerRadius(10)
    }
}
