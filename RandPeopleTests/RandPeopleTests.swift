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
            it("page in call we made and servers page have to be the same") {
                
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
        }
    }
}
