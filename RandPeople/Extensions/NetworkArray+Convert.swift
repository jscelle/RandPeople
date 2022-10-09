//
//  NetworkArray+Convert.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation

extension Array where Element == User {
    func toDomain() -> [DomainUser] {
        compactMap { user in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            guard
                let imageUrl = URL(string: user.picture.large),
                let date = dateFormatter.date(from: user.dob.date)
            else {
                return nil
            }
            
            return DomainUser(
                name: "\(user.name.first) \(user.name.last)",
                email: user.email,
                gender: user.gender,
                yearCount: user.dob.age,
                dob: date,
                time: "",
                imageUrl: imageUrl
            )
        }
    }
}
