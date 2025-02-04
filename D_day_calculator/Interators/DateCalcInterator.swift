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
    func calculate(mode: Mode, dateContext: DateContext) -> String
}

extension DateCalcProtocol {
    func calcDiffDate(from dateContext: DateContext) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: dateContext.startDate)
        let startOfToday = calendar.startOfDay(for: dateContext.endDate)
        let result = calendar.dateComponents([.day], from: startOfTarget, to: startOfToday).day ?? 0
        return result
    }
}

struct DateCalcInterator: DateCalcProtocol{
    func calculate(mode: Mode, dateContext: DateContext) -> String {
        switch mode {
        case .dDay:
            return dDayCalc(from: dateContext)
        case .counting:
            return countingCalc(from: dateContext)
        }
    }
    
    private func dDayCalc(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext)
        
        if day == 0 {
            return "Event day"
        } else if day > 0 {
            return "\(day) days ago"
        } else {
            let absDay = abs(day)
            return "\(absDay) days"
        }
    }
    
    private func countingCalc(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext) + 1
        
        return "\(day) days"
    }
}




   
    
    

