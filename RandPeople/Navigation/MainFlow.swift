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
            case .personOverview(let user):
                return personOverview(user: user)
            case .showImage(let imageURL):
                return showImage(imageURL: imageURL)
        }
    }
    
    private func mainScreen() -> FlowContributors {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        
        rootNavigationController.pushViewController(viewController, animated: false)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: viewController,
                withNextStepper: viewModel
            )
        )
    }
    
    private func personOverview(user: DomainUser) -> FlowContributors {
        let viewModel = OverviewViewModel()
        let viewController = OverviewViewController(
            user: user,
            viewModel: viewModel
        )
        
        rootNavigationController.pushViewController(
            viewController,
            animated: true
        )
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: viewController,
                withNextStepper: viewModel
            )
        )
    }
    
    private func showImage(imageURL: URL) -> FlowContributors {
        let viewController = ImageViewController(imageURL: imageURL)
        viewController.modalPresentationStyle = .popover
        
        guard let topViewController = rootNavigationController.topViewController else {
            return .none
        }
        
        topViewController.present(viewController, animated: true)
        
        return .end(forwardToParentFlowWithStep: MainStep.mainScreen)
    }
}
