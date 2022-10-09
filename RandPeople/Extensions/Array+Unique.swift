//
//  DomainUser+Set.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
