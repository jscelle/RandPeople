//
//  DetailsViewController.swift
//  RandPeople
//
//  Created by Artem Raykh on 10.10.2022.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

final class OverviewViewController: UIViewController  {
    
    private let disposeBag = DisposeBag()
    
    private lazy var overView = OverviewView(user: user)
    
    private let user: DomainUser
    
    private let viewModel: OverviewViewModel
    
    init(
        user: DomainUser,
        viewModel: OverviewViewModel
    ) {
        self.viewModel = viewModel
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.background()
        
        view.addSubview(overView)
        
        overView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        overView.setupViews()
        
        overView.userImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer()
        overView.userImageView.addGestureRecognizer(tapGesture)
        
        tapGesture
            .rx
            .event
            .bind (onNext: { [weak self] recognizer in
                
                guard let self = self else {
                    return
                }
                
                print("tapped")
                
                self.viewModel.showImage(imageURL: self.user.image.large)
            })
            .disposed(by: disposeBag)
            
    }
}
