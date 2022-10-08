//
//  RandomUserAPI.swift
//  RandPeople
//
//  Created by Artem Raykh on 06.10.2022.
//

import Foundation
import Moya

struct RandomUserAPI: TargetType {
    
    var baseURL: URL
    
    var path: String
    
    var method: Moya.Method
    
    var task: Task
    
    var headers: [String : String]?
}

extension RandomUserAPI {
    static func getRandomUsers(page: Int) -> RandomUserAPI {
        RandomUserAPI(
            baseURL: URL(string: "https://randomuser.me")!,
            path: "/api",
            method: .get,
            task: .requestParameters(
                parameters: [
                    "page" : page,
                    "results": 10
                ],
                encoding: URLEncoding.queryString
            )
        )
    }
}
