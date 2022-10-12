//
//  MainViewModelTest.swift
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
import RxTest

@testable import RandPeople

final class MainViewModelTest: QuickSpec {
    
    override func spec() {
        super.spec()
        
        var viewModel: MainViewModel!
        var input: MainInput!
        var output: MainOutput!
        
        var disposeBag: DisposeBag!
        var scheduler: TestScheduler!
        
        var trigger: Observable<Void>!
        
        
        
        beforeEach {
            
            disposeBag = DisposeBag()
            scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: true)
            
            viewModel = MainViewModel(repository: MockRepository())
            
            trigger = scheduler.createHotObservable([
                .next(100, ()),
                .next(200, ()),
                .next(300, ())
            ])
            .asObservable()
            
            input = MainInput(trigger: trigger)
            
            output = viewModel.transform(input: input)
            
        }
        
        describe("Main view model") {
            
            it("should increase by page size ever time page changes (1 in mock example) and also not contains only unique elements") {
                
                expect(output.items.compactMap { $0.count })
                    .events(scheduler: scheduler, disposeBag: disposeBag)
                    .to(
                        equal([
                            Recorded.next(100, 1),
                            Recorded.next(200, 2),
                            Recorded.next(300, 2)
                        ])
                    )
            }
            
            it("should throw errors") {
                
            }
        }
    }
}

final class MockRepository: Repository {
    func getUsers(page: Int) -> Observable<[DomainUser]> {
        switch page {
        case 1:
            return Observable.of(MockUsers.networkUser)
        case 2:
            return Observable.of(MockUsers.dataBaseUser)
        case 3:
            return Observable.of(MockUsers.networkUser)
        default:
            return .error(MockErrors.err)
        }
    }
}
