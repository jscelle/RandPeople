//
//  MainInput.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

struct MainInput {
    var page = PublishRelay<Int>()
}

struct MainOutput {
    var items: Driver<[User]>
    let error: Driver<Error>
}
