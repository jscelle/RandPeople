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

protocol NetworkManagerType {
    func getRandomUsers(page: Int) -> Observable<Response>
}

final class NetworkManager: NetworkManagerType {
    private let provider = MoyaProvider<RandomUserAPI>()
    
    func getRandomUsers(page: Int) -> Observable<Response> {
        provider
            .rx
            .request(
                .getRandomUsers(page: page)
            )
            .map(Response.self)
            .asObservable()
    }
}
