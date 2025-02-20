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
    func calcToString(mode: Mode, dateContext: DateContext) -> String
    func calcToInt(mode: Mode, dateContext: DateContext) -> Int
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
    func calcToString(mode: Mode, dateContext: DateContext) -> String {
        let days = daysCalc(mode: mode, dateContext: dateContext)
        return daysCalcToString(from: days, mode: mode)
    }
    
    func calcToInt(mode: Mode, dateContext: DateContext) -> Int {
        return abs(daysCalc(mode: mode, dateContext: dateContext))
    }
    
    private func daysCalc(mode: Mode, dateContext: DateContext) -> Int {
        switch mode {
        case .dDay:
            return calcDiffDate(from: dateContext)
        case .counting:
            return calcDiffDate(from: dateContext) + 1
        }
    }
    
    private func daysCalcToString(from days: Int, mode: Mode) -> String {
        switch mode {
        case .dDay:
            if days == 0 {
                return "Event day"
            } else if days > 0 {
                return "Passed"
            } else {
                let absDay = abs(days)
                return "\(absDay) days"
            }
        case .counting:
            return "+\(days) days"
        }
    }
}




   
    
    

