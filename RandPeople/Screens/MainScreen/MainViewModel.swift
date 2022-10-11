//
//  MainViewModel.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import RxRelay

final class MainViewModel: ViewModel, Stepper {
        
    private let repository: Repository
    
    private var inProgress = false
    
    var steps = PublishRelay<Step>()
        
    init(repository: Repository = UserRepository(
        dbManager: RealmManager(),
        networkManager: UserNetworkManager()
        )
    ) {
        self.repository = repository
    }
    
    func transform(input: MainInput) -> MainOutput {
        
        let errorRouter = ErrorRouter()
                
        let page = input
            .trigger
            .scan(0) { value, _ in
                value + 1
            }
        
        let response = page
            .flatMapFirst { [repository] page in
                repository.getUsers(page: page)
                    .rerouteError(errorRouter)
            }
        
        let users = response
            .scan(into: [DomainUser]()) { current, next in
                if next.count != 0 {
                    return current.append(contentsOf: next)
                }
            }
            .map { $0.unique }
        
        return MainOutput(
            items: users
                .asDriver(onErrorRecover: { _ in fatalError() }),
            error: errorRouter
                .error
                .compactMap { $0.localizedDescription }
                .asDriver(onErrorRecover: { _ in fatalError() })
        )
    }
    
    func showOverview(user: DomainUser) {
        steps.accept(MainStep.personOverview(user: user))
    }
}
