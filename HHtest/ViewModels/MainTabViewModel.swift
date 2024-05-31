//
//  MainTabViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 30.05.2024.
//

import Foundation
import CoreData

class MainTabViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    @Published var favoriteVacanciesCount: Int = 0
    
    private let fetchedResultsController: NSFetchedResultsController<FavoriteVacancyEntity>
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        let fetchRequest: NSFetchRequest<FavoriteVacancyEntity> = FavoriteVacancyEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "publishedDate", ascending: false)]
        
        self.fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        self.fetchedResultsController.delegate = self
        
        do {
            try self.fetchedResultsController.performFetch()
            self.updateFavoriteVacanciesCount()
        } catch {
            print("Failed to fetch favorite vacancies: \(error.localizedDescription)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.updateFavoriteVacanciesCount()
    }
    
    private func updateFavoriteVacanciesCount() {
        if let favorites = fetchedResultsController.fetchedObjects {
            favoriteVacanciesCount = favorites.count
        } else {
            favoriteVacanciesCount = 0
        }
    }
}
