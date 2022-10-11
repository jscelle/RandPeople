//
//  UserCollectionViewCell.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation
import SnapKit
import Kingfisher

final class UserCollectionViewCell: UICollectionViewCell {
    
    static let indetifier = "UserCollectionViewCell"
    
    private var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var nameLabel = UILabel.defaultLabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(userImageView)
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).inset(-10)
        }
        
        backgroundColor = .lightGray.withAlphaComponent(0.08)
        layer.cornerRadius = 10
    }
    
    func configureCell(with item: DomainUser) {
        userImageView.kf.setImage(with: item.image.large)
        nameLabel.text = item.name
    }
}

