//
//  Convertor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import Foundation

enum DateFormat: String {
    case USA = "MMM d, yyyy"
}

extension Date {
    func formatted(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current // 로컬 타임존 설정

        let localTimeString = formatter.string(from: self)
        
        return localTimeString
    }
            
    static func today() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    static func getDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        let calendar = Calendar.current
        if let targetDate = calendar.date(from: dateComponents) {
            return targetDate
        } else {
            fatalError(
                """
                Invalid date components: 
                year=\(year), month=\(month), day=\(day), 
                hour=\(hour), minute=\(minute), second=\(second).                 
                """
            )
        }
    }
    
    static func local() -> String {
        let date = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current

        let localTimeString = formatter.string(from: date)
        return localTimeString
    }
    
    static func midnight(from now: Date) -> Date {        
        let calendar = Calendar.current
        let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 2), matchingPolicy: .strict) ?? now
        
        return midnight
    }
}
