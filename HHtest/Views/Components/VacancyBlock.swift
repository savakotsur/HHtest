//
//  VacancyBlock.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import SwiftUI

struct VacancyBlock: View {
    var vacancy: Vacancy
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            VStack (alignment: .leading) {
                if vacancy.lookingNumber != nil {
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
                
                Text("Опубликовано " + viewModel.formattedDate(from: vacancy.publishedDate))
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
                        viewModel.addToFavorites(vacancyID: vacancy.id)
                    }
            } else {
                Image("favorites.active")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .onTapGesture {
                        viewModel.removeFromFavorites(vacancyID: vacancy.id)
                    }
            }
        }
        .padding(20)
        .background(Color("gray1"))
        .cornerRadius(12)
    }
}

//struct VacancyBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        VacancyBlock(vacancy: Vacancy(id: "1", lookingNumber: 1, title: "UI/UX Designer", address: Address(town: "Минск", street: "улица Бирюзова", house: "4/5"), company: "Мобирикс", experience: Experience(previewText: "Опыт от 1 года до 3 лет", text: "Требуемый опыт: от 1 года до 3 лет"), publishedDate: "2024-02-20", isFavorite: true, salary: Salary(full: "Уровень дохода не указан", short: nil), schedules: ["полная занятость", "полный день"], appliedNumber: 147, vacancyDescription: nil, responsibilities: "", questions: []))
//    }
//}
