//
//  VacancyScroll.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI

struct VacancyScroll: View {
    let vacancy: Vacancy
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                if let appliedNumber = vacancy.appliedNumber {
                    HStack {
                        Text(appliedNumber.applied())
                        Spacer()
                        Image("profile")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("white"))
                            .frame(width: 15, height: 15)
                            .padding(4)
                            .background(Color("green"))
                            .cornerRadius(100)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: screenSize.width / 1.9, minHeight: screenSize.height / 13, maxHeight: screenSize.height / 12)
                    .background(Color("darkGreen"))
                    .cornerRadius(10)
                }
                if let lookingNumber = vacancy.lookingNumber {
                    if lookingNumber != 0 {
                        HStack {
                            Text(lookingNumber.people() + " сейчас " + lookingNumber.looking())
                            Spacer()
                            Image("lookingnumber")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(4)
                                .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 15)
                        .frame(maxWidth: screenSize.width / 1.9, minHeight: screenSize.height / 13, maxHeight: screenSize.height / 12)
                        .background(Color("darkGreen"))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.vertical, 10)
    }
}
