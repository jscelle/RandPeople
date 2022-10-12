//
//  RepositoryTest.swift
//  RandPeopleTests
//
//  Created by Artem Raykh on 07.10.2022.
//

import Quick
import RxNimble
import RxSwift
import RxCocoa
import Nimble
import RxBlocking
import RxTest

@testable import RandPeople

final class RepositoryTest: QuickSpec {
    
    override func spec() {
        super.spec()
        
        var repository: UserRepository!
        
        var disposeBag: DisposeBag!
        var scheduler: TestScheduler!
        
        beforeEach {
            
            disposeBag = DisposeBag()
            scheduler = TestScheduler(initialClock: 0)
            
            repository = UserRepository(
                dbManager: MockDataBaseManager(),
                networkManager: MockNetworkManager()
            )
        }
        
        describe("Repository") {
            
            context("Get users") {
                
                it("it have to be network response if there is no error, and db response if error code is 6, otherwise repository should throw an error") {
                    
                    let response = scheduler.createHotObservable([
                        .next(100, 1),
                        .next(200, 2),
                        .next(300, 3)
                    ])
                    .flatMap { repository.getUsers(page: $0) }
                    
                    let fakeError = MockErrors.err
                    
                    expect(response)
                        .events(scheduler: scheduler, disposeBag: disposeBag)
                        .to(
                            equal([
                                Recorded.next(100, MockUsers.networkUser),
                                Recorded.next(200, MockUsers.dataBaseUser),
                                Recorded.error(300, fakeError)
                            ])
                        )
                }
            }
        }
    }
}

struct MockNetworkManager: NetworkManager {
    
    func getUsers(page: Int) -> Observable<[DomainUser]> {
        
        switch page {
        case 2:
            return .error(MockErrors.internet)
        case 3:
            return .error(MockErrors.err)
        default:
            return Observable.just(MockUsers.networkUser)
        }
    }
}

final class MockDataBaseManager: DatabaseManager {
    func getUsers() -> Observable<[DomainUser]> {
        Observable.just(MockUsers.dataBaseUser)
    }
    
    func saveUsers(users: [DomainUser]) { }
}

struct MockUsers {
    static let dataBaseUser = [
        DomainUser(
            name: "dbUser",
            email: "dbUser",
            gender: "dbUser",
            yearCount: 53,
            dob: Date(),
            offset: "+12:00",
            image: DomainUser.Image(
                thumbnail: URL(string: "https://soundcloud.com")!,
                medium: URL(string: "https://soundcloud.com")!,
                large: URL(string: "https://soundcloud.com")!
            )
        )
    ]
    
    static let networkUser = [
        DomainUser(
            name: "networkUser",
            email: "networkUser",
            gender: "networkUser",
            yearCount: 35,
            dob: Date(),
            offset: "-12:00",
            image: DomainUser.Image(
                thumbnail: URL(string: "https://soundcloud.com")!,
                medium: URL(string: "https://soundcloud.com")!,
                large: URL(string: "https://soundcloud.com")!
            )
        )
    ]
}

struct MockErrors {
    static let internet = NSError(domain: "Test internet error", code: 6)
    static let err = NSError(domain: "Test error", code: 15)
}
