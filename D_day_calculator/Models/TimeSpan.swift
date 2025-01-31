//
//  TimeSpan.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

@Model
class TimeSpan: Equatable {
    @Attribute(.unique) var id: String
    var createdDate = Date()
    var title: String
    var startDate: Date
    var endDate: Date
    var mode: Mode
    var calculatedDays: String
    
    init(id: String? = UUID().uuidString,
         createdDate: Date? = Date(),
         title: String,
         startDate: Date,
         endDate: Date,
         mode: Mode,
         calculatedDays: String
    ){
        self.id = id ?? UUID().uuidString
        self.createdDate = createdDate ?? Date()
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.mode = mode
        self.calculatedDays = calculatedDays
    }     
}
