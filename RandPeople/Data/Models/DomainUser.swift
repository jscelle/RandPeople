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
    let offset: String
    
    let image: Image
    
    struct Image {
        let thumbnail: URL
        let medium: URL
        let large: URL
    }
}

extension DomainUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
    
    static func == (lhs: DomainUser, rhs: DomainUser) -> Bool {
        return lhs.email == rhs.email
    }
}

extension Array where Element == DomainUser {
    func toRealm() -> [RealmDomainModel] {
        compactMap { user in
            let model = RealmDomainModel()
            
            model.name = user.name
            model.email = user.email
            model.gender = user.gender
            model.yearCount = user.yearCount
            model.dob = user.dob
            model.offset = user.offset
            
            model.image = RealmImageModel()
            model.image?.thumbnail = user.image.thumbnail.absoluteString
            model.image?.medium = user.image.medium.absoluteString
            model.image?.large = user.image.large.absoluteString
            
            return model
        }
    }
}
