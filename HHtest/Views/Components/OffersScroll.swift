//
//  OffersScroll.swift
//  HHtest
//
//  Created by Савелий Коцур on 29.05.2024.
//

import SwiftUI

struct OffersScroll: View {
    var body: some View {
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
                            .padding(.bottom, 10)
                        Text("Вакансии рядом с вами")
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .padding(10)
                    .frame(maxWidth: screenSize.width / 2.6, minHeight: screenSize.height / 6, alignment: .topLeading)
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
                            .padding(.bottom, 10)
                        Text("Поднять резюме в поиске")
                            .font(.callout)
                            .fontWeight(.medium)
                        Text("Поднять")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color("greenMain"))
                    }
                    .padding(10)
                    .frame(maxWidth: screenSize.width / 2.6, minHeight: screenSize.height / 6, alignment: .topLeading)
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
                            .padding(.bottom, 10)
                        Text("Временная работа или подработка")
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .padding(10)
                    .frame(maxWidth: screenSize.width / 2.6, minHeight: screenSize.height / 6, alignment: .topLeading)
                    .background(Color("grayMain"))
                    .cornerRadius(10)
                }
            }
        }.padding(.vertical, 8)
            .padding(.bottom, 20)
    }
}
