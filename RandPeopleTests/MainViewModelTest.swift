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
        var input = MainInput()
        var output: MainOutput!
        
        var disposeBag: DisposeBag!
        var scheduler: TestScheduler!
        
        beforeEach {
            
            disposeBag = DisposeBag()
            scheduler = TestScheduler(initialClock: 0)
            
            viewModel = MainViewModel(networkManager: MockNetworkManager())
            
            output = viewModel.transform(input: input)
            
            scheduler.createHotObservable([
                .next(100, 1),
                .next(1000, 2)
            ])
            .bind(to: input.page)
            .disposed(by: disposeBag)
            
        }
        
        describe("Main view model") {
            
            context("has to populate users array") {
                
                it("it should increase by page size ever time page changes") {
                    
                    expect(output.items.compactMap { $0.count })
                        .events(scheduler: scheduler, disposeBag: disposeBag)
                        .to(
                            equal([
                                Recorded.next(100, 1),
                                Recorded.next(1000, 2)
                            ])
                    )
                }
            }
        }
    }
}
