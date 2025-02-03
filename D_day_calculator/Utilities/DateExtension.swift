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
    
    static func today() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    static func getDate(year: Int, month: Int, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        
        let calendar = Calendar.current
        if let targetDate = calendar.date(from: dateComponents) {
            return targetDate
        } else {
            fatalError("Invalid date components: year=\(year), month=\(month), day=\(day). Please check input values.")
        }
    }
}
