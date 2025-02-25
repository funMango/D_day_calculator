//
//  DefaultData.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/17/25.
//

import Foundation

class DefaultData {
    static func getDefaultTimeSpans() -> [TimeSpan] {
        return  [
            TimeSpan(
                title: "📱 new phone release day!",
                selectedDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.today()) ?? Date.today(),
                today: Date.today(),
                mode: .dDay,
                calculatedDays: "3days"
            ),
            TimeSpan(
                title: "💻 new notebook release day!",
                selectedDate: Calendar.current.date(byAdding: .day, value: -9, to: Date.today()) ?? Date.today(),
                today: Date.today(),
                mode: .counting,
                calculatedDays: "+10days"
            )
        ]
    }
}
