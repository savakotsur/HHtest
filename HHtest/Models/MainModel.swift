//
//  MainModel.swift
//  HHtest
//
//  Created by Савелий Коцур on 28.05.2024.
//

import Foundation

// MARK: - HomeScreen
struct HomeScreenData: Decodable {
    var offers: [Offer]
    var vacancies: [Vacancy]
}

// MARK: - Offer
struct Offer: Identifiable, Decodable {
    let id: String?
    let title: String
    let link: String
    let button: MyButton?
}

// MARK: - Button
struct MyButton: Decodable {
    let text: String
}

// MARK: - Vacancy
struct Vacancy: Identifiable, Decodable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    var isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let vacancyDescription: String?
    let responsibilities: String
    let questions: [String]
}

// MARK: - Address
struct Address: Decodable {
    let town, street, house: String
}

// MARK: - Experience
struct Experience: Decodable {
    let previewText, text: String
}

// MARK: - Salary
struct Salary: Decodable {
    let full: String
    let short: String?
}
