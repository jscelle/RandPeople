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
    
    var root: Presentable {
        return self.rootNavigationController
    }
    
    private var rootNavigationController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        
        guard let step = step as? MainStep else {
            return .none
        }
        
        switch step {
            case .mainScreen:
                return mainScreen()
            case .personOverview:
                return .none
        }
    }
    
    private func mainScreen() -> FlowContributors {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        
        rootNavigationController.pushViewController(viewController, animated: false)
        rootNavigationController.isNavigationBarHidden = true
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: viewController,
                withNextStepper: viewModel
            )
        )
    }
}
