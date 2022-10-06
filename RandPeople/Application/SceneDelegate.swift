//
//  SceneDelegate.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import UIKit
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let coordinator = FlowCoordinator()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        setup(scene: scene)
    }

    private func setup(scene: UIWindowScene) {
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let mainFlow = MainFlow()
        
        Flows.use(mainFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        coordinator.coordinate(
            flow: mainFlow,
            with: OneStepper(withSingleStep: MainStep.mainScreen)
        )
    }
}

