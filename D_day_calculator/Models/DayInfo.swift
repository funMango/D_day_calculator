//
//  DayInfo.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import Foundation

struct DayInfo: Hashable {
    var title: String
    var targetDate: Date
    var mode: Mode
    
    init(title: String, targetDate: Date, mode: Mode) {
        self.title = title
        self.targetDate = targetDate
        self.mode = mode
    }
    
    func calcDateDiff() -> Int {
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day, .hour, .minute, .second],
            from: targetDate,
            to: today
        )
        
        return components.day ?? 0
    }
    
    func getTargetDate() -> String {
        return Convertor.convertToDate(date: targetDate, format: "yyyy.MM.dd")
    }
}
