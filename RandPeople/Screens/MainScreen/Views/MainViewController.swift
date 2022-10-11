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
    
    private lazy var collectionView: UserCollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        let cellWidht = (view.frame.size.width - 30) / 2
        
        let cellSize = CGSize(
            width: cellWidht,
            height: cellWidht * 1.3
        )
        
        collectionViewLayout.itemSize = cellSize
        
        collectionViewLayout.scrollDirection = .vertical
        
        let collectionView = UserCollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.register(
            UserCollectionViewCell.self,
            forCellWithReuseIdentifier: UserCollectionViewCell.indetifier
        )
        return collectionView
    }()
    
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
        
        view.backgroundColor = UIColor(
            red: 20/255,
            green: 10/255,
            blue: 20/255,
            alpha: 1
        )
        
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
    }
}
