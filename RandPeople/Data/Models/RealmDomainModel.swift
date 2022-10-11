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
    @Persisted var imageUrl: String
}
