//
//  DomainUser.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation

struct DomainUser {
    let name: String
    let email: String
    let gender: String
    let yearCount: Int
    let dob: Date
    let timezone: String
    let timestamp: String
    let imageUrl: URL
}

extension DomainUser {
    static func convert(from users: [User]) -> [DomainUser] {
        users.compactMap { user in
            #warning("make age and dob here!!!")
            guard let imageUrl = URL(string: user.picture.large) else {
                return nil
            }
            
            return DomainUser(
                name: user.name.title,
                email: user.email,
                gender: user.gender,
                yearCount: 12,
                dob: Date(),
                timezone: user.location.timezone.timezoneDescription,
                timestamp: user.location.timezone.offset,
                imageUrl: imageUrl
            )
        }
    }
}
