//
//  RealmDomainModel.swift
//  RandPeople
//
//  Created by Artem Raykh on 08.10.2022.
//

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted var name: String
    @Persisted(primaryKey: true) var email: String
    @Persisted var gender: String
    @Persisted var yearCount: Int
    @Persisted var dob: Date
    @Persisted var time: String
    
    @Persisted var image: RealmImageModel?
}

final class RealmImageModel: Object {
    
    @Persisted var thumbnail: String
    @Persisted var medium: String
    @Persisted var large: String
}

extension Results where Element == RealmDomainModel {
    func toDomain() -> [DomainUser] {
        compactMap { user in
            
            guard
                let image = user.image,
                let thumbnail = URL(string: image.thumbnail),
                let medium = URL(string: image.medium),
                let large = URL(string: image.large)
            else {
                return nil
            }
            
            return DomainUser(
                name: user.name,
                email: user.email,
                gender: user.gender,
                yearCount: user.yearCount,
                dob: user.dob,
                time: user.time,
                image: DomainUser.Image(
                    thumbnail: thumbnail,
                    medium: medium,
                    large: large
                )
            )
        }
    }
}
