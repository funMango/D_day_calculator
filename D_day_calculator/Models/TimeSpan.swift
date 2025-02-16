//
//  TimeSpan.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

@Model
class TimeSpan: Equatable, CustomStringConvertible {
    var id = ""
    var createdDate = Date.today()
    var title = ""
    var selectedDate = Date.today()
    var today = Date.today()
    var mode = Mode.dDay
    var calculatedDays = ""
    var days: Int = 0
    
    init(id: String? = UUID().uuidString,
         createdDate: Date? = Date(),
         title: String,
         selectedDate: Date,
         today: Date,
         mode: Mode,
         calculatedDays: String,
         days: Int = 0
    ){
        self.id = id ?? UUID().uuidString
        self.createdDate = createdDate ?? Date()
        self.title = title
        self.selectedDate = selectedDate
        self.today = today
        self.mode = mode
        self.calculatedDays = calculatedDays
        self.days = days
    }
    
// MARK: - getter
    func getStartDate() -> String {
        switch mode {
        case .dDay:
            return self.today.formatted(DateFormat.USA.rawValue)
        case .counting:
            return self.selectedDate.formatted(DateFormat.USA.rawValue)
        }
    }
    
    func getEndDate() -> String {
        switch mode {
        case .dDay:
            return self.selectedDate.formatted(DateFormat.USA.rawValue)
        case .counting:
            return self.today.formatted(DateFormat.USA.rawValue)
        }
    }
    
    // MARK: - setter
    func update(today: Date, calculatedDays: String, days: Int) {
        self.today = today
        self.calculatedDays = calculatedDays
        self.days = days
    }
            
    var description: String {            
            return """
            TimeSpan:
              - id: \(id)
              - title: \(title)
              - selectedDate: \(selectedDate)
              - today: \(today)
              - mode: \(mode)
              - calculatedDays: \(calculatedDays)
              - days: \(days)
            """
        }
}
