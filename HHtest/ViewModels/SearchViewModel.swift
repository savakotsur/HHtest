//
//  SearchViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import CoreData
import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var homeScreenData: HomeScreenData?
    @Binding var navigationPath: NavigationPath
    private var cancellable: AnyCancellable?
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, path: Binding<NavigationPath>) {
        self._navigationPath = path
        self.context = context
        loadHomeScreen(from: URL(string: "https://run.mocky.io/v3/d67a278f-ddcb-438c-bf56-3194c529b12b")!)
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidChange), name:.NSManagedObjectContextObjectsDidChange, object: context)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name:.NSManagedObjectContextObjectsDidChange, object: context)
        cancellable?.cancel()
    }
    
    @objc func contextDidChange(_ notification: Notification) {
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        
        do {
            let favoriteVacancies = try context.fetch(fetchRequest)
            
            var favoriteVacanciesDict = [String: FavoriteVacancyEntity]()
            for vacancy in favoriteVacancies {
                favoriteVacanciesDict[vacancy.id!] = vacancy
            }
            
            homeScreenData?.vacancies = homeScreenData?.vacancies.map { vacancy in
                if let favoriteVacancy = favoriteVacanciesDict[vacancy.id] {
                    var updatedVacancy = vacancy
                    updatedVacancy.isFavorite = true
                    return updatedVacancy
                } else {
                    var updatedVacancy = vacancy
                    updatedVacancy.isFavorite = false
                    return updatedVacancy
                }
            } ?? []
        } catch {
            print("Failed to fetch vacancies from CoreData: \(error)")
        }
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
        var savedVacancy = vacancy
        savedVacancy.isFavorite = true
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", savedVacancy.id)
        
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
        let addressEntity = AddressEntity(context: context)
        addressEntity.house = vacancy.address.house
        addressEntity.town = vacancy.address.town
        addressEntity.street = vacancy.address.street
        
        let salaryEntity = SalaryEntity(context: context)
        salaryEntity.full = vacancy.salary.full
        salaryEntity.short = vacancy.salary.short
        
        let expirienceEntity = ExpirienceEntity(context: context)
        expirienceEntity.previewText = vacancy.experience.previewText
        expirienceEntity.text = vacancy.experience.text
        
        favoriteVacancy.id = vacancy.id
        favoriteVacancy.lookingNumber = Int32(vacancy.lookingNumber ?? 0)
        favoriteVacancy.title = vacancy.title
        favoriteVacancy.company = vacancy.company
        favoriteVacancy.publishedDate = vacancy.publishedDate
        favoriteVacancy.isFavorite = vacancy.isFavorite
        favoriteVacancy.appliedNumber = Int32(vacancy.appliedNumber ?? 0)
        favoriteVacancy.vacancyDescription = vacancy.vacancyDescription
        favoriteVacancy.responsibilities = vacancy.responsibilities
        favoriteVacancy.schedules = vacancy.schedules as NSArray
        favoriteVacancy.questions = vacancy.questions as NSArray
        favoriteVacancy.address = addressEntity
        favoriteVacancy.salary = salaryEntity
        favoriteVacancy.expirience = expirienceEntity
    }
    
    func loadHomeScreen(from url: URL) {
        let decoder = JSONDecoder()
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: HomeScreenData.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching home screen: \(error)")
                }
            }, receiveValue: { [weak self] homeScreenData in
                self?.homeScreenData = homeScreenData
                self?.syncFavoritesWithCoreData()
            })
    }
    
    private func syncFavoritesWithCoreData() {
        guard let homeScreenData = self.homeScreenData else {
            return
        }
        
        for vacancy in homeScreenData.vacancies {
            if vacancy.isFavorite {
                saveToCoreData(vacancy: vacancy)
            } else {
                deleteFromCoreData(vacancyID: vacancy.id)
            }
        }
    }
    
    func didSelectVacancy(_ vacancy: Vacancy) {
        let vacancyCoordinator = VacancyCoordinator(navigationPath: $navigationPath, vacancy: vacancy)
        push(vacancyCoordinator)
    }
    
    private func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
    
    
}
