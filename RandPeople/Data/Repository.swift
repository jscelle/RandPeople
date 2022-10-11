//
//  Repository.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol Repository {
    func getUsers(page: Int) -> Observable<[DomainUser]>
}
#warning("make complete on db response return")
final class UserRepository: Repository {
    
    private let dbManager: DatabaseManager
    private let networkManager: NetworkManager
    
    init(
        dbManager: DatabaseManager,
        networkManager: NetworkManager
    ) {
        self.dbManager = dbManager
        self.networkManager = networkManager
    }
    
    func getUsers(page: Int) -> Observable<[DomainUser]> {
        // 6 is probably error code for the internet connection lost
        networkManager
            .getUsers(page: page)
            .do(onNext: { [dbManager] users in
                dbManager.saveUsers(users: users)
            })
            .catch { [dbManager] error in
                
                if (error as NSError).code == 6 {
                    return dbManager.getUsers()
                }
                
                return .error(error)
        }
    }
}
