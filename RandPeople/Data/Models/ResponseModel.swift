//
//  PersonModel.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation

struct Response: Codable {
    let results: [User]
    let info: Info
}

struct Info: Codable {
    let page: Int
}

struct User: Codable {
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
    let large, medium, thumbnail: String
}

extension Array where Element == User {
    func toDomain() -> [DomainUser] {
        compactMap { user in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            guard
                let thumbnailURL = URL(string: user.picture.thumbnail),
                let mediumURL = URL(string: user.picture.medium),
                let largeURL = URL(string: user.picture.large),
                let dobDate = dateFormatter.date(from: user.dob.date)
            else {
                return nil
            }
            
            return DomainUser(
                name: "\(user.name.first) \(user.name.last)",
                email: user.email,
                gender: user.gender,
                yearCount: user.dob.age,
                dob: dobDate,
                offset: user.location.timezone.offset,
                image: DomainUser.Image(
                    thumbnail: thumbnailURL,
                    medium: mediumURL,
                    large: largeURL
                )
            )
        }
    }
}
