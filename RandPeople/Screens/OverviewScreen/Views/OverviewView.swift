//
//  OverviewView.swift
//  RandPeople
//
//  Created by Artem Raykh on 11.10.2022.
//

import SnapKit

final class OverviewView: UIView {
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var genderIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    lazy var nameLabel = UILabel.defaultLabel()
    
    lazy var dateLabel = UILabel.defaultLabel()
    
    lazy var ageLabel = UILabel.defaultLabel()
    
    lazy var emailLabel = UILabel.defaultLabel()
    
    lazy var timeLabel = UILabel.defaultLabel()
    
    init(user: DomainUser) {
        super.init(frame: CGRect.zero)
        configureView(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(200)
            make.width.equalTo(120)
        }
                
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.top)
            make.left.equalTo(userImageView.snp.right).inset(-10)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        nameLabel.backgroundColor = .white.withAlphaComponent(0.05)
        
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
            make.height.equalTo(60)
        }
        
        dateLabel.backgroundColor = .white.withAlphaComponent(0.05)
        
        addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(-10)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(dateLabel.snp.right)
            make.height.equalTo(60)
        }
        
        emailLabel.backgroundColor = .white.withAlphaComponent(0.05)
        
        addSubview(genderIcon)
        
        genderIcon.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).inset(-10)
            make.left.equalTo(userImageView.snp.left)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(genderIcon.snp.top)
            make.left.equalTo(genderIcon.snp.right).inset(-10)
            make.right.equalTo(nameLabel.snp.right)
            make.height.equalTo(60)
        }
        
        timeLabel.backgroundColor = .white.withAlphaComponent(0.05)
    }
    
    private func configureView(user: DomainUser) {
        userImageView.kf.setImage(with: user.image.large)
        nameLabel.text = user.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd LLLL yyyy"
        dateLabel.text = "\(formatter.string(from: user.dob)), \(user.yearCount)"
        emailLabel.text = user.email
        genderIcon.tintColor = user.gender == "female" ? .systemPink : .blue
        timeLabel.text = user.time
    }
}
