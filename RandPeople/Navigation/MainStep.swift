//
//  MainStep.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import RxFlow

enum MainStep: Step {
    case mainScreen
    case personOverview(user: DomainUser)
    case showImage(image: URL)
}
