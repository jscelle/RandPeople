//
//  UserCollectionViewCell.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation
import SnapKit
import Kingfisher

class UserCollectionViewCell: UICollectionViewCell {
    
    static let indetifier = "UserCollectionViewCell"
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    func configureCell(with item: DomainUser) {
        
        addSubview(nameLabel)
        addSubview(imageView)
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).inset(-10)
        }
        
        backgroundColor = .lightGray.withAlphaComponent(0.05)
        layer.cornerRadius = 10
        
        imageView.kf.setImage(with: item.imageUrl)
        nameLabel.text = item.name
    }
}

