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
        
    private let networkManager: NetworkManager
    
    private var inProgress = false
    
    var steps = PublishRelay<Step>()
        
    init(networkManager: NetworkManager = UserNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func transform(input: MainInput) -> MainOutput {
        
        let errorRouter = ErrorRouter()
        
        let response = input
            .page
            .flatMap { [networkManager] page in
                Observable.zip(
                    Observable.just(page),
                    networkManager.getUsers(page: page)
                        .rerouteError(errorRouter)
                )
            }
        
        let pages = response
            .map { ($0.0, $0.1.results) }
            .scan(into: [Int: [User]]()) { current, next in
                current[next.0] = next.1
            }
        
        let users = pages
            .map { pages in
                pages.sorted {
                    $0.key < $1.key
                }
                .flatMap { $0.value }
            }
        
        return MainOutput(
            items: users.asDriver(onErrorDriveWith: .empty()),
            error: errorRouter.error.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func getUsers(page: Int) -> Single<[User]> {
        networkManager
            .getUsers(page: page)
            .compactMap { $0.results }
            .asSingle()
    }
    
    func navigate(to step: MainStep) {
        steps.accept(step)
    }
}
