//
//  RealmManager.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation
import RxSwift

protocol DatabaseManager {
    func getUsers(page: Int) -> Observable<[DomainUser]>
    func saveUsers(users: [User]) -> Observable<Bool>
}

//class RealmManager: UserDatabaseManagerType {
//    func getUsers(page: Int) -> Observable<[User]> {
//        
//    }
//    
//    func saveUsers(users: [User]) -> Observable<Bool> {
//        
//    }
//}
