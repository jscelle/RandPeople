//
//  OverviewViewModel.swift
//  RandPeople
//
//  Created by Artem Raykh on 11.10.2022.
//

import Foundation
import RxFlow
import RxSwift
import RxRelay
import RxCocoa

final class OverviewViewModel: Stepper {
    
    var steps = PublishRelay<Step>()
    
    func showImage(image: URL) {
        steps.accept(MainStep.showImage(image: image))
    }
}
