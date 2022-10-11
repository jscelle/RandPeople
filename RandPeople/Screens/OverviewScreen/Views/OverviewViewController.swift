//
//  DetailsViewController.swift
//  RandPeople
//
//  Created by Artem Raykh on 10.10.2022.
//

import Foundation
import SnapKit

final class OverviewViewController: UIViewController  {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 20/255,
            green: 10/255,
            blue: 20/255,
            alpha: 1
        )
        view.addSubview(overView)
        
        overView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        overView.setupViews()
    }
}
