//
//  NetworkManager.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

final class NetworkManager {
    let provider = MoyaProvider<RandomUserAPI>()
    
    func getRandomUsers(page: Int) -> Observable<User> {
        provider
            .rx
            .request(
                .getRandomUsers(page: page)
            )
            .map(User.self)
            .asObservable()
    }
}
