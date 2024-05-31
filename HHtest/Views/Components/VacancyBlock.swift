//
//  VacancyBlock.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import SwiftUI

struct VacancyBlock: View {
    var vacancy: Vacancy
    let onSelect: (Vacancy) -> Void
    var onFavoriteTapped: () -> Void
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            VStack (alignment: .leading) {
                if vacancy.lookingNumber != nil && vacancy.lookingNumber != 0{
                    Text("Сейчас просматривает " + vacancy.lookingNumber!.people())
                        .foregroundColor(Color("green"))
                }
                Text(vacancy.title)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.vertical, 3)
                if vacancy.salary.short != nil {
                    Text(vacancy.salary.short!)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 3)
                }
                Text(vacancy.address.town)
                
                HStack (alignment: .center) {
                    Text(vacancy.company)
                    Image("checkmark")
                }
                .padding(.top, -10)
                
                HStack (alignment: .center) {
                    Image("expirience")
                    Text(vacancy.experience.previewText)
                }
                
                Text("Опубликовано " + vacancy.publishedDate.formattedDate())
                    .foregroundColor(Color("gray3"))
                Button(action: {
                    print("Кнопка откликнуться нажата")
                })
                {
                    Text("Откликнуться")
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, minHeight: screenSize.height / 20)
                .background(Color("green"))
                .cornerRadius(100)
            }
            if vacancy.isFavorite == false {
                Image("favorites")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .onTapGesture {
                        onFavoriteTapped()
                    }
            } else {
                Image("favorites.active")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .onTapGesture {
                        onFavoriteTapped()
                    }
            }
        }
        .padding(20)
        .background(Color("gray1"))
        .cornerRadius(12)
        .onTapGesture {
            onSelect(vacancy)
        }
    }
}
