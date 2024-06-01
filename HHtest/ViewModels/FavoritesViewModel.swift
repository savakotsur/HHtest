//
//  FavoritesViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import CoreData
import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteVacancies: [Vacancy] = []
    @Binding var navigationPath: NavigationPath
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, path: Binding<NavigationPath>) {
        self._navigationPath = path
        self.context = context
        fetchFavoriteVacancies()
    }
    
    private func fetchFavoriteVacancies() {
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        
        do {
            let favoriteVacanciesEntities = try context.fetch(fetchRequest)
            for entity in favoriteVacanciesEntities {
                favoriteVacancies.append(toVacancy(from: entity))
            }
        } catch {
            print("Error fetching favorite vacancies: \(error.localizedDescription)")
        }
    }
    
    func removeFromFavorites(vacancyID: String) {
        deleteFromCoreData(vacancyID: vacancyID)
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
    
    func toVacancy(from favoriteVacancy: FavoriteVacancyEntity) -> Vacancy {
        let addressEntity = favoriteVacancy.address
        let salaryEntity = favoriteVacancy.salary
        let expirienceEntity = favoriteVacancy.expirience
        let schedulesArray = favoriteVacancy.schedules as? NSArray
        let schedules = schedulesArray?.compactMap { $0 as? String }
        let questionsArray = favoriteVacancy.questions as? NSArray
        let questions = questionsArray?.compactMap { $0 as? String }
        
        let address = Address(
            town: addressEntity?.town ?? "",
            street: addressEntity?.street ?? "",
            house: addressEntity?.house ?? ""
        )
        
        let salary = Salary(full: salaryEntity?.full ?? "", short: salaryEntity?.short)
        
        let expirience = Experience(previewText: expirienceEntity?.previewText ?? "", text: expirienceEntity?.text ?? "")
        
        let vacancy = Vacancy(
            id: favoriteVacancy.id ?? "",
            lookingNumber: Int(favoriteVacancy.lookingNumber),
            title: favoriteVacancy.title ?? "",
            address: address,
            company: favoriteVacancy.company ?? "",
            experience: expirience,
            publishedDate: favoriteVacancy.publishedDate ?? "",
            isFavorite: favoriteVacancy.isFavorite,
            salary: salary,
            schedules: schedules ?? [],
            appliedNumber: Int(favoriteVacancy.appliedNumber),
            vacancyDescription: favoriteVacancy.vacancyDescription ?? "",
            responsibilities: favoriteVacancy.responsibilities ?? "",
            questions: questions ?? []
        )
        
        return vacancy
    }
    
    func didSelectVacancy(_ vacancy: Vacancy) {
        let vacancyCoordinator = VacancyCoordinator(navigationPath: $navigationPath, vacancy: vacancy)
        push(vacancyCoordinator)
    }
    
    private func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
