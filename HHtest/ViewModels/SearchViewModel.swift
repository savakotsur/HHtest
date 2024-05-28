//
//  SearchViewModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 27.05.2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private var coordinator: SearchCoordinator
    @Published var homeScreenData: HomeScreenData?
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        loadHomeScreen(from: URL(string: "https://run.mocky.io/v3/d67a278f-ddcb-438c-bf56-3194c529b12b")!)
    }
    
    func toggleFavorite(for vacancyID: String) {
        if let index = homeScreenData!.vacancies.firstIndex(where: { $0.id == vacancyID }) {
            homeScreenData!.vacancies[index].isFavorite.toggle()
        }
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
}
