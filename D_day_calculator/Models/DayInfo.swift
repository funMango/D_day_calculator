//
//  DayInfo.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import Foundation

struct DayInfo: Hashable {
    var title: String
    var startDay: Date
    var endDate: Date
    var dDay: Int
    
    init(title: String, startDay: Date, endDate: Date) {
        self.title = title
        self.startDay = startDay
        self.endDate = endDate
        self.dDay = DayInfo.calcDateDiff(from: startDay, to: endDate)
    }
    
    static func calcDateDiff(from startDate: Date, to dDay: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day, .hour, .minute, .second],
            from: startDate,
            to: dDay
        )
        
        return components.day ?? 0
    }
}
