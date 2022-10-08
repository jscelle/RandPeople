//
//  Repository.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol Repository {
    func getUsers() -> Observable<[DomainUser]>
    func storeUsers(users: [DomainUser])
}
#warning("make page for each data source (by scan probably), make block then data executes")
final class UserRepository: Repository {
    
    private let reachability: Reachability
    private let dbManager: DatabaseManager
    private let networkManager: NetworkManager
    
    private let initialPage = 1
    
    init(
        dbManager: DatabaseManager,
        networkManager: NetworkManager,
        reachability: Reachability
    ) {
        self.dbManager = dbManager
        self.networkManager = networkManager
        self.reachability = reachability
    }
    
    func getUsers() -> Observable<[DomainUser]> {
        let reach = reachability
            .reach
            .skip(0)
        
        let observables = Observable.zip(
            reach,
            networkManager.getUsers(page: 1),
            dbManager.getUsers(page: 1)
        )
        .map {
            if $0.0 {
                return DomainUser.convert(from: $0.1.results)
            }
            return $0.2
        }
        
        return observables
    }
    
    func storeUsers(users: [DomainUser]) {
        
    }
}
