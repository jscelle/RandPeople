//
//  UserCollectionView.swift
//  RandPeople
//
//  Created by Artem Raykh on 09.10.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class UserCollectionView: UICollectionView {
    func isNearBottom(offset: CGPoint) -> Single<Bool> {
        
        let startOffset: CGFloat = 30
        
        let isNearBottom = offset.y + frame.size.height + startOffset > contentSize.height
        
        return Single.just(isNearBottom)
    }
}
