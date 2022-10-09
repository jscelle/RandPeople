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
    let time: String
    let imageUrl: URL
}

extension DomainUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
    
    static func == (lhs: DomainUser, rhs: DomainUser) -> Bool {
        return lhs.email == rhs.email
    }
}
