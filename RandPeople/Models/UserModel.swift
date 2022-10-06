//
//  PersonModel.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation

struct User: Codable {
    let results: [Result]
    let info: Info
}

struct Info: Codable {
    let page: Int
}

struct Result: Codable {
    let gender: String
    let name: Name
    let location: Location
    let dob: Dob
    let email: String
    let picture: Picture
}

struct Dob: Codable {
    let date: String
    let age: Int
}

struct Location: Codable {
    let timezone: Timezone
}

struct Timezone: Codable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

struct Name: Codable {
    let title, first, last: String
}

struct Picture: Codable {
    let large, medium, thumbnail: URL
}
