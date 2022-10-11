//
//  Date+Local time.swift
//  RandPeople
//
//  Created by Artem Raykh on 11.10.2022.
//

import Foundation

extension Date {
    
    static func localtime(actualOffset: String) -> Date? {
        
        let date = Date()
        
        if actualOffset == "0:00" {
            return date
        }
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = actualOffset.contains("-") ? "-HH:mm" : "+HH:mm"
        
        guard let absDate = formatter.date(from: actualOffset) else {
            return nil
        }
        
        let hours = Calendar.current.component(.hour, from: absDate)
        let minutes = Calendar.current.component(.minute, from: absDate)
        
        let timeInterval = actualOffset.contains("-") ? (-hours * 60 * 60 - minutes * 60) : (hours * 60 * 60 + minutes * 60)
        
        return date.addingTimeInterval(TimeInterval(timeInterval))
    }
    
    func formatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
