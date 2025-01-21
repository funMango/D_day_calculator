//
//  DateInterator.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/16/25.
//

import Foundation

struct DateContext {
    var startDate: Date
    var endDate: Date
    var mode: Mode    
}

protocol DateCalcProtocol {
    func execute(from dateContext: DateContext) -> String
}

extension DateCalcProtocol {
    func calcDiffDate(from dateContext: DateContext) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: dateContext.startDate)
        let startOfToday = calendar.startOfDay(for: dateContext.endDate)
        let result = calendar.dateComponents([.day], from: startOfTarget, to: startOfToday).day
        return result ?? 0
    }
}

struct DdayCalcInterator: DateCalcProtocol {
    func execute(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext)
        
        if day == 0 {
            return "D-day"
        }
        
        return "D\(day)"
    }
}

struct CountingCalcInterator: DateCalcProtocol {
    func execute(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext) + 1
        
        return "\(day) days"
    }
}


   
    
    

