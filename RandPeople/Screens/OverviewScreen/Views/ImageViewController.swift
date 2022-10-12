//
//  ImageViewController.swift
//  RandPeople
//
//  Created by Artem Raykh on 10.10.2022.
//

import SnapKit
import Kingfisher

final class ImageViewController: UIViewController {
    
    private lazy var imageView = UIImageView.defaultImageView()
    
    init(imageURL: URL) {
        super.init(nibName: nil, bundle: nil)
        configureImageView(imageURL: imageURL)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = UIColor.background()
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    private func configureImageView(imageURL: URL) {
        imageView.kf.setImage(with: imageURL)
    }
}
