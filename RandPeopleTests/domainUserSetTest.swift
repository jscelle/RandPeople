//
//  domainUserSetTest.swift
//  RandPeopleTests
//
//  Created by Artem Raykh on 09.10.2022.
//

import Quick
import Nimble
import Foundation

@testable import RandPeople

final class uniqueArrayTest: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("Extension for arrays") {
            
            it("has to convert array of domain users to array of unique domain users") {
                
                let array: [DomainUser] = [
                    MockUsers.networkUser.first!,
                    MockUsers.dataBaseUser.first!,
                    MockUsers.dataBaseUser.first!
                ]
                
                expect(array.unique.count)
                    .to(equal(2))
            }
        }
    }
}
