//
//  RealmArray+Convert.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation
import RealmSwift

extension Results where Element == RealmDomainModel {
    func toDomain() -> [DomainUser] {
        compactMap { user in
            
            guard let url = URL(string: user.imageUrl) else {
                return nil
            }
            
            return DomainUser(
                name: user.name,
                email: user.email,
                gender: user.gender,
                yearCount: user.yearCount,
                dob: user.dob,
                time: user.time,
                imageUrl: url
            )
        }
    }
}
