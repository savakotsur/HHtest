//
//  VacancyViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 31.05.2024.
//

import Foundation
import CoreData

class VacancyViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var vacancy: Vacancy
    
    init(context: NSManagedObjectContext, vacancy: Vacancy) {
        self.context = context
        self.vacancy = vacancy
    }
    
    func schedulesText() -> String {
        var schedulesString = ""
        for i in 0..<vacancy.schedules.count {
            if i == 0 {
                schedulesString.append(vacancy.schedules[i].prefix(1).capitalized + vacancy.schedules[i].dropFirst())
                schedulesString.append(", ")
            } else {
                schedulesString.append(vacancy.schedules[i])
                if i != vacancy.schedules.count - 1 {
                    schedulesString.append(", ")
                }
            }
        }
        return schedulesString
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
    
    func saveToCoreData(vacancy: Vacancy) {
        var savedVacancy = vacancy
        savedVacancy.isFavorite = true
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", savedVacancy.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingVacancy = results.first {
                configure(existingVacancy, with: savedVacancy)
            } else {
                let newVacancy = FavoriteVacancyEntity(context: context)
                configure(newVacancy, with: savedVacancy)
            }
            try context.save()
            print("Vacancy saved successfully.")
        } catch {
            print("Error saving vacancy: \(error.localizedDescription)")
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
}
