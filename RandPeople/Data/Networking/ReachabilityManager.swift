//
//  Reachability.swift
//  RandPeople
//
//  Created by Artem Raykh on 07.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import Alamofire

protocol Reachability {
    var reach: BehaviorRelay<Bool> { get set }
}

final class ReachabilityManager {
    
    var reach = BehaviorRelay<Bool>(value: true)
    
    init() {
        self.setup()
    }
    
    private func setup() {
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { [weak self] status in
            
            guard let self = self else {
                return
            }
            
            switch status {
            case .notReachable:
                self.reach.accept(false)
            case .reachable:
                self.reach.accept(true)
            case .unknown:
                self.reach.accept(false)
            }
        })
    }
}
