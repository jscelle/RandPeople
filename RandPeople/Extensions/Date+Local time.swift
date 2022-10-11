//
//  Date+Local time.swift
//  RandPeople
//
//  Created by Artem Raykh on 11.10.2022.
//

import Foundation

extension Date {
    static func localtime(fromGMT: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "+hh:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: <#T##Int#>)
        
        return ""
    }
}
