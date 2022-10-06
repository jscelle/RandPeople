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
                
                it("it should increase by 10 ever time page changes") {
                    
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

final class MockNetworkManager: NetworkManagerType {
    func getRandomUsers(page: Int) -> Observable<Response> {
        
        let decoder = JSONDecoder()
        
        let response = try! decoder.decode(Response.self, from: jsonString.data(using: .utf8)!)
        
        return Observable.just(response)
    }
    
    let jsonString = """
    {"results":[{"gender":"female","name":{"title":"Ms","first":"Lyubanya","last":"Miskiy"},"location":{"street":{"number":9545,"name":"Poperechna"},"city":"Brodi","state":"Kiyivska","country":"Ukraine","postcode":23361,"coordinates":{"latitude":"79.2169","longitude":"142.9608"},"timezone":{"offset":"+8:00","description":"Beijing, Perth, Singapore, Hong Kong"}},"email":"lyubanya.miskiy@example.com","login":{"uuid":"79cdfb16-2f31-4a9b-b710-47907f53d20a","username":"angryfish537","password":"angel","salt":"7ogOJTpC","md5":"4a3ebbeeeac673ca1a9cb252f4e733e0","sha1":"e60dff982dd511e822f583b53c1d206453c1dfe1","sha256":"56e1f5ee4a151780af96b9712b9a98f268e6e28a7fe217e8f8c0008e576b3af4"},"dob":{"date":"1976-12-08T16:30:48.678Z","age":45},"registered":{"date":"2002-09-15T19:59:31.963Z","age":20},"phone":"(099) I28-1068","cell":"(068) U17-5922","id":{"name":"","value":null},"picture":{"large":"https://randomuser.me/api/portraits/women/44.jpg","medium":"https://randomuser.me/api/portraits/med/women/44.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/44.jpg"},"nat":"UA"}],"info":{"seed":"6f9c5ba47601a0d3","results":1,"page":1,"version":"1.4"}}
    """
}
