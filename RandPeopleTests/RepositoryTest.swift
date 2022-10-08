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
        
        var reachability: Reachability!
        
        var disposeBag: DisposeBag!
        var scheduler: TestScheduler!
        
        beforeEach {
            
            disposeBag = DisposeBag()
            scheduler = TestScheduler(initialClock: 0)
            
            reachability = MockReachabilityManager()
            
            repository = UserRepository(
                dbManager: MockDataBaseManager(),
                networkManager: MockNetworkManager(),
                reachability: reachability
            )
        }
        
        describe("Repository") {
            context("Get users") {
                let networkUsers = MockUserStorage.getUser(type: .network).results
                let networkEmail = DomainUser.convert(from: networkUsers).first!.email

                let dbUsers = MockUserStorage.getUser(type: .db).results
                let dbEmail = DomainUser.convert(from: dbUsers).first!.email
                
                it("if internet connection is on, than it returns network reponse") {
                    reachability.reach.accept(true)
                    
                    expect(
                        repository.getUsers().compactMap { $0.first?.email }
                    )
                    .first
                    .to(equal(networkEmail))
                }
                
                it("if connection is off, than it returns db response") {
                    
                    reachability.reach.accept(false)
                    
                    expect(
                        repository.getUsers().compactMap { $0.first?.email }
                    )
                    .first
                    .to(equal(dbEmail))
                }
            }
        }
    }
}

final class MockReachabilityManager: Reachability {
    var reach = BehaviorRelay(value: true)
}

final class MockNetworkManager: NetworkManager {
    func getUsers(page: Int) -> Observable<Response> {
        return Observable.just(MockUserStorage.getUser(type: .network))
    }
}

final class MockDataBaseManager: DatabaseManager {
    func getUsers(page: Int) -> Observable<[DomainUser]> {
        Observable.just(MockUserStorage.getUser(type: .db))
            .compactMap { DomainUser.convert(from: $0.results) }
    }
    
    func saveUsers(users: [User]) -> Observable<Bool> {
        Observable.just(true)
    }
}

struct MockUserStorage {
    
    enum TypeOfResponse: String {
        case db
        case network
    }
    
    static let dataBaseJson = """
    {
      "results": [
        {
          "gender": "female",
          "name": {
            "title": "Miss",
            "first": "Jennie",
            "last": "Nichols"
          },
          "location": {
            "street": {
              "number": 8929,
              "name": "Valwood Pkwy",
            },
            "city": "Billings",
            "state": "Michigan",
            "country": "United States",
            "postcode": "63104",
            "coordinates": {
              "latitude": "-69.8246",
              "longitude": "134.8719"
            },
            "timezone": {
              "offset": "+9:30",
              "description": "Adelaide, Darwin"
            }
          },
          "email": "jennie.nichols@example.com",
          "login": {
            "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
            "username": "yellowpeacock117",
            "password": "addison",
            "salt": "sld1yGtd",
            "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
            "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
            "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d"
          },
          "dob": {
            "date": "1992-03-08T15:13:16.688Z",
            "age": 30
          },
          "registered": {
            "date": "2007-07-09T05:51:59.390Z",
            "age": 14
          },
          "phone": "(272) 790-0888",
          "cell": "(489) 330-2385",
          "id": {
            "name": "SSN",
            "value": "405-88-3636"
          },
          "picture": {
            "large": "https://randomuser.me/api/portraits/men/75.jpg",
            "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
            "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
          },
          "nat": "US"
        }
      ],
      "info": {
        "seed": "56d27f4a53bd5441",
        "results": 1,
        "page": 1,
        "version": "1.4"
      }
    }
    """
    
    static let networkJson = """
    {
      "results": [
        {
          "gender": "female",
          "name": {
            "title": "Miss",
            "first": "Jennie",
            "last": "Nichols"
          },
          "location": {
            "street": {
              "number": 8929,
              "name": "Valwood Pkwy",
            },
            "city": "Billings",
            "state": "Michigan",
            "country": "United States",
            "postcode": "63104",
            "coordinates": {
              "latitude": "-69.8246",
              "longitude": "134.8719"
            },
            "timezone": {
              "offset": "+9:30",
              "description": "Adelaide, Darwin"
            }
          },
          "email": "jennie.nichols@example.com",
          "login": {
            "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
            "username": "yellowpeacock117",
            "password": "addison",
            "salt": "sld1yGtd",
            "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
            "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
            "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d"
          },
          "dob": {
            "date": "1992-03-08T15:13:16.688Z",
            "age": 30
          },
          "registered": {
            "date": "2007-07-09T05:51:59.390Z",
            "age": 14
          },
          "phone": "(272) 790-0888",
          "cell": "(489) 330-2385",
          "id": {
            "name": "SSN",
            "value": "405-88-3636"
          },
          "picture": {
            "large": "https://randomuser.me/api/portraits/men/75.jpg",
            "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
            "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
          },
          "nat": "US"
        }
      ],
      "info": {
        "seed": "56d27f4a53bd5441",
        "results": 1,
        "page": 1,
        "version": "1.4"
      }
    }
    """
    
    static func getUser(type: TypeOfResponse) -> Response {
        
        let string: String
        
        if type == .network {
            string = networkJson
        } else {
            string = dataBaseJson
        }
        
        return try! JSONDecoder().decode(
            Response.self,
            from: string.data(using: .utf8)!
        )
    }
}
