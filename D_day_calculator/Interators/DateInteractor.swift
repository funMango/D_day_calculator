//
//  DateInterator.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/16/25.
//

import Foundation

enum TimeRegion: String {
    case seoul = "Asia/Seoul"
}

enum TimeRegionError: String, Error {
    case InvalidRegion = "Invalid region name entered"
}

struct DateContext {
    var targetDate: Date
    var today: Date
    var mode: Mode
    var timeRegion: TimeRegion
}

protocol DateInteractor{
    func execute(from dateContext: DateContext) -> String
}

struct DateDiffInteractor: DateInteractor{
    func execute(from dateContext: DateContext) -> String {
        switch dateContext.mode {
        case .dDay:
            return calcDday(from: dateContext)
        case .counting:
            return calcCountingDay(from: dateContext)
        }                        
    }
    
    private func calcDday(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext)
        
        if day == 0 {
            return "D-day"
        }
        
        return "D\(day)"
    }
    
    private func calcCountingDay(from dateContext: DateContext) -> String {
        let day = calcDiffDate(from: dateContext) + 1
        
        return "\(day) days"
    }
    
    private func calcDiffDate(from dateContext: DateContext) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: dateContext.targetDate)
        let startOfToday = calendar.startOfDay(for: dateContext.today)
        let result = calendar.dateComponents([.day], from: startOfTarget, to: startOfToday).day
        return result ?? 0
    }
}
