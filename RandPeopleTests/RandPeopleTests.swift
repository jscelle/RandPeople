//
//  RandPeopleTests.swift
//  RandPeopleTests
//
//  Created by Artem Raykh on 06.10.2022.
//

import Quick
import RxNimble
import RxSwift
import RxCocoa
import Nimble
import RxBlocking

@testable import RandPeople

final class NetworkManagerTest: QuickSpec {
    override func spec() {
        super.spec()
        
        var network: NetworkManager!
        
        beforeEach {
            network = NetworkManager()
        }
        
        describe("Network manager") {
            
            it("page in call we made and server response page has to be the same") {
                
                [1,2,3,4,10].forEach { page in
                    expect(
                        network.getRandomUsers(page: page)
                            .compactMap {
                                $0.info.page
                            }
                    )
                    .first
                    .to(equal(page))
                }
                
            }
            
            it("network manager returns right amount of users") {
                expect(network.getRandomUsers(page: 1).compactMap { $0.results.count })
                    .first
                    .to(equal(10))
            }
        }
    }
}
