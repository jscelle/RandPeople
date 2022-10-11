//
//  UILabel + Fabric.swift
//  RandPeople
//
//  Created by Artem Raykh on 11.10.2022.
//

import UIKit

extension UILabel {
    static func defaultLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }
}
