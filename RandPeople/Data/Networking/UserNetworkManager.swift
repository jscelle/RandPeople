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


protocol NetworkManager {
    func getUsers(page: Int) -> Observable<[DomainUser]>
}

final class UserNetworkManager: NetworkManager {
    
    private let provider = MoyaProvider<RandomUserAPI>()
    
    func getUsers(page: Int) -> Observable<[DomainUser]> {
        provider
            .rx
            .request(.getRandomUsers(page: page))
            .map(Response.self)
            .compactMap { $0.results.toDomain() }
            .asObservable()
    }
}
