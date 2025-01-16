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
    var referenceDate: Date
    var timeRegion: TimeRegion
}

protocol DateInteractor{
    func execute(from dateContext: DateContext) -> Int
}

struct DateDiffInteractor: DateInteractor{
    func execute(from dateContext: DateContext) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: dateContext.targetDate)
        let startOfToday = calendar.startOfDay(for: dateContext.referenceDate)
        let result = calendar.dateComponents([.day], from: startOfTarget, to: startOfToday).day
        return result ?? 0
    }
}
