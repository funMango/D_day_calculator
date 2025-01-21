//
//  TimeSpan.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

@Model
class TimeSpan {
    @Attribute(.unique) var id = UUID().uuidString
    var createdDate = Date()
    var title: String
    var startDate: Date
    var endDate: Date
    var mode: Mode
    var calculatedDays: String
    
    init(title: String, startDate: Date, endDate: Date, mode: Mode, calculatedDays: String) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.mode = mode
        self.calculatedDays = calculatedDays
    }
}
