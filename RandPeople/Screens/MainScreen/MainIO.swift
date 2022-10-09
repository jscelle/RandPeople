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
    var trigger: Observable<Void>
}

struct MainOutput {
    var items: Driver<[DomainUser]>
    let error: Driver<String>
}
