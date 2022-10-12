//
//  MainViewController + Alert.swift
//  RandPeople
//
//  Created by Artem Raykh on 12.10.2022.
//

import UIKit


extension MainViewController {
    func presentError(message: String) {
        
        let alert = UIAlertController(
            title: "Error occured",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Button",
                style: .default,
                handler: nil
            )
        )
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
}

