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
    
    enum CodingKeys: String, CodingKey {
        case vacancyDescription = "description"
        
        case id
        case lookingNumber
        case title
        case address
        case company
        case experience
        case publishedDate
        case isFavorite
        case salary
        case schedules
        case appliedNumber
        case responsibilities
        case questions
    }
    
    init(id: String, lookingNumber: Int?, title: String, address: Address, company: String, experience: Experience, publishedDate: String, isFavorite: Bool, salary: Salary, schedules: [String], appliedNumber: Int?, vacancyDescription: String?, responsibilities: String, questions: [String]) {
        self.id = id
        self.lookingNumber = lookingNumber
        self.title = title
        self.address = address
        self.company = company
        self.experience = experience
        self.publishedDate = publishedDate
        self.isFavorite = isFavorite
        self.salary = salary
        self.schedules = schedules
        self.appliedNumber = appliedNumber
        self.vacancyDescription = vacancyDescription
        self.responsibilities = responsibilities
        self.questions = questions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.lookingNumber = try container.decodeIfPresent(Int.self, forKey: .lookingNumber)
        self.title = try container.decode(String.self, forKey: .title)
        self.address = try container.decode(Address.self, forKey: .address)
        self.company = try container.decode(String.self, forKey: .company)
        self.experience = try container.decode(Experience.self, forKey: .experience)
        self.publishedDate = try container.decode(String.self, forKey: .publishedDate)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        self.salary = try container.decode(Salary.self, forKey: .salary)
        self.schedules = try container.decode([String].self, forKey: .schedules)
        self.appliedNumber = try container.decodeIfPresent(Int.self, forKey: .appliedNumber)
        self.vacancyDescription = try container.decodeIfPresent(String.self, forKey: .vacancyDescription)
        self.responsibilities = try container.decode(String.self, forKey: .responsibilities)
        self.questions = try container.decode([String].self, forKey: .questions)
    }
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

extension Int {
    func people() -> String {
        var peopleString = "человек"
        if String(self % 10).contains(/[2-4]/) {peopleString = "человека"}
        if 11...14 ~= self % 100 {peopleString = "человек"}
        return "\(self) " + peopleString
    }
    
    func looking() -> String {
        var looking = ""
        if self == 1 {looking = "просматривает"}
        else {looking = "просматривают"}
        return looking
    }
    
    func applied() -> String {
        var appliedString = ""
        appliedString.append(String(self) + " человек уже ")
        if self == 1 {appliedString.append("откликнулся")}
        else {appliedString.append("откликнулись")}
        return appliedString
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

extension String {
    func formattedDate() -> String {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "d MMMM"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}
