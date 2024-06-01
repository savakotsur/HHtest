//
//  VacancyMapBlock.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI

struct VacancyMapBlock: View {
    let vacancy: Vacancy
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(vacancy.company)
                    .fontWeight(.semibold)
                    .font(.title3)
                Image("checkmark")
            }
            Image("map")
                .resizable()
                .frame(width: screenSize.width / 1.2, height: screenSize.height / 13)
                .cornerRadius(10)
            Text(vacancy.address.town + ", " + vacancy.address.street + ", " + vacancy.address.house)
        }
        .padding(15)
        .padding(.horizontal, 20)
        .frame(minWidth: screenSize.width / 1.2, minHeight: screenSize.height / 10)
        .background(Color("gray1"))
        .cornerRadius(10)
    }
}
