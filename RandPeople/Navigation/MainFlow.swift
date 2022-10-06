//
//  MainFlow.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import RxFlow
import UIKit

final class MainFlow: Flow {
    
    var root: Presentable = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        
        guard let step = step as? MainStep else {
            return .none
        }
        
        switch step {
            
            case .mainScreen:
                return .none
            case .personOverview:
                return .none
        }
    }
}
