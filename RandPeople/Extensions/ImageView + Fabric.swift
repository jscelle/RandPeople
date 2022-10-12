//
//  ImageView + Fabric.swift
//  RandPeople
//
//  Created by Artem Raykh on 12.10.2022.
//

import UIKit

extension UIImageView {
    static func defaultImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
