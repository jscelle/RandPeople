//
//  ViewController.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView = userCollectionView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        collectionView.backgroundColor = .clear
        
        view.backgroundColor = UIColor.background()
        
        let trigger = collectionView
            .rx
            .contentOffset
            .flatMap { [collectionView] offset in
                collectionView.isNearBottom(offset: offset)
            }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in () }
        
        let input = MainInput(trigger: trigger)
        
        subscribeToEvents(input: input)
    }
    
    private func subscribeToEvents(input: MainInput) {
        let output = viewModel.transform(input: input)
        
        output
            .items
            .drive(
                collectionView.rx.items(
                    cellIdentifier: UserCollectionViewCell.indetifier,
                    cellType: UserCollectionViewCell.self
                )
            ) { row, data, cell in
                cell.configureCell(with: data)
            }.disposed(by: disposeBag)
        
        collectionView
            .rx
            .modelSelected(DomainUser.self)
            .bind { [viewModel] user in
                viewModel.showOverview(user: user)
            }
            .disposed(by: disposeBag)
        
        output
            .error
            .drive { [weak self] error in
                self?.presentError(message: error)
            }
            .disposed(by: disposeBag)
    }
}
