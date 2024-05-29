//
//  SearchViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import CoreData
import Foundation

class SearchViewModel: ObservableObject {
    private var coordinator: SearchCoordinator
    @Published var homeScreenData: HomeScreenData?
    
    private let context = PersistenceController.shared.container.viewContext
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        loadHomeScreen(from: URL(string: "https://run.mocky.io/v3/d67a278f-ddcb-438c-bf56-3194c529b12b")!)
    }
    
    func addToFavorites(vacancyID: String) {
        if let index = homeScreenData?.vacancies.firstIndex(where: { $0.id == vacancyID }) {
            homeScreenData?.vacancies[index].isFavorite = true
            saveToCoreData(vacancy: homeScreenData!.vacancies[index])
        }
    }
    
    func removeFromFavorites(vacancyID: String) {
        if let index = homeScreenData?.vacancies.firstIndex(where: { $0.id == vacancyID }) {
            homeScreenData?.vacancies[index].isFavorite = false
            deleteFromCoreData(vacancyID: vacancyID)
        }
    }
    
    private func saveToCoreData(vacancy: Vacancy) {
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", vacancy.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingVacancy = results.first {
                configure(existingVacancy, with: vacancy)
            } else {
                let newVacancy = FavoriteVacancyEntity(context: context)
                configure(newVacancy, with: vacancy)
            }
            try context.save()
            print("Vacancy saved successfully.")
        } catch {
            print("Error saving vacancy: \(error.localizedDescription)")
        }
    }
    
    
    private func deleteFromCoreData(vacancyID: String) {
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", vacancyID)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let vacancyToDelete = results.first {
                context.delete(vacancyToDelete)
                try context.save()
                print("Vacancy deleted successfully.")
            }
        } catch {
            print("Failed to delete vacancy: \(error.localizedDescription)")
        }
    }
    
    private func configure(_ favoriteVacancy: FavoriteVacancyEntity, with vacancy: Vacancy) {
        favoriteVacancy.id = vacancy.id
        favoriteVacancy.lookingNumber = Int32(vacancy.lookingNumber ?? 0)
        favoriteVacancy.title = vacancy.title
        favoriteVacancy.company = vacancy.company
        favoriteVacancy.publishedDate = vacancy.publishedDate
        favoriteVacancy.isFavorite = vacancy.isFavorite
        favoriteVacancy.appliedNumber = Int32(vacancy.appliedNumber ?? 0)
        favoriteVacancy.vacancyDescription = vacancy.vacancyDescription
        favoriteVacancy.responsibilities = vacancy.responsibilities
        favoriteVacancy.schedules = vacancy.schedules as NSObject
        favoriteVacancy.questions = vacancy.questions as NSObject
    }
    
    
    func formattedDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "d MMMM"
            dateFormatter.locale = Locale(identifier: "ru_RU") // Установим локаль для русского языка
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
    func loadHomeScreen(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching home screen: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let homeScreenData = try JSONDecoder().decode(HomeScreenData.self, from: data)
                DispatchQueue.main.async {
                    self.homeScreenData = homeScreenData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
    
    //    func addToFavorites(vacancy: Vacancy) {
    //        //ADD TO COREDATA
    //        if let index = vacancies.firstIndex(where: { $0.id == vacancy.id }) {
    //                vacancies[index].isFavorite = true
    //        }
    //    }
}

extension Int {
    func people() -> String {
        var peopleString = "человек"
        if String(self % 10).contains(/[2-4]/) {peopleString = "человека"}
        if 11...14 ~= self % 100 {peopleString = "человек"}
        return "\(self) " + peopleString
    }
    
    func vacancies() -> String {
        var vacanciesString = "вакансий"
        if String(self % 10).contains(/[1]/) {vacanciesString = "вакансия"}
        if String(self % 10).contains(/[2-4]/) {vacanciesString = "вакансии"}
        if String(self % 10).contains(/[5-9]/) {vacanciesString = "вакансий"}
        if 11...14 ~= self % 100 {vacanciesString = "вакансий"}
        return "\(self) " + vacanciesString
    }
}
