//
//  RealmManager.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation
import RxSwift
import RealmSwift

protocol DatabaseManager {
    func getUsers() -> Observable<[DomainUser]>
    func saveUsers(users: [DomainUser])
}

class RealmManager: DatabaseManager {
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func getUsers() -> Observable<[DomainUser]> {
        let response = realm
            .objects(RealmDomainModel.self)
            .toDomain()
        
        return Observable.just(response)
    }
    
    func saveUsers(users: [DomainUser]) {
        
        try! realm.write {
            
            users
                .toRealm()
                .forEach { user in
                    if realm.object(
                        ofType: RealmDomainModel.self,
                        forPrimaryKey: user.email
                    ) == nil {
                        realm.add(user)
                }
            }
        }
    }
}
