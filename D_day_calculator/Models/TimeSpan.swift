//
//  TimeSpan.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

@Model
class TimeSpan: Equatable, Identifiable, CustomStringConvertible {
    @Attribute(.unique) var id: String
    var createdDate = Date()
    var title: String
    var selectedDate: Date
    var today: Date
    var mode: Mode
    var calculatedDays: String
    
    init(id: String? = UUID().uuidString,
         createdDate: Date? = Date(),
         title: String,
         selectedDate: Date,
         today: Date,
         mode: Mode,
         calculatedDays: String
    ){
        self.id = id ?? UUID().uuidString
        self.createdDate = createdDate ?? Date()
        self.title = title
        self.selectedDate = selectedDate
        self.today = today
        self.mode = mode
        self.calculatedDays = calculatedDays
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
    func update(today: Date, calculatedDays: String) {
        self.today = today
        self.calculatedDays = calculatedDays
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
            """
        }
}
