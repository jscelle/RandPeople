//
//  DomainArray+Convert.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation

extension Array where Element == DomainUser {
    func toRealm() -> [RealmDomainModel] {
        compactMap { user in
            let model = RealmDomainModel()
            
            model.name = user.name
            model.email = user.email
            model.gender = user.gender
            model.yearCount = user.yearCount
            model.dob = user.dob
            model.time = user.time
            model.imageUrl = user.imageUrl.absoluteString
            
            return model
        }
    }
}
