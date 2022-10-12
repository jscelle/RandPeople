//
//  MainViewController + CollectionView.swift
//  RandPeople
//
//  Created by Artem Raykh on 12.10.2022.
//

import UIKit

extension MainViewController {
    func userCollectionView() -> UserCollectionView {
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
    }
}
