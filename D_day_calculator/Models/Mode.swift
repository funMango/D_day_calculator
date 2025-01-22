//
//  Mode.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

enum Mode: String, CaseIterable, Hashable, Codable {
    case dDay = "D-day"
    case counting = "Counting"
            
    var content: String {
        switch self {
        case .dDay:
            return "Choose D-Day from today"
        case .counting:
            return "Counting day from specified date"
        }
    }
    
    var dateReference: String {
        switch self {
        case .dDay:
            return "Until"
        case .counting:
            return "From"
        }
    }
}
