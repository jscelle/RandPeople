//
//  ImageViewController.swift
//  RandPeople
//
//  Created by Artem Raykh on 10.10.2022.
//

import SnapKit

final class ImageViewController: UIViewController {
    
    init(imageURL: URL) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
