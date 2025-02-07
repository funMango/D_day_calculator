//
//  Mode.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

enum Mode: String, CaseIterable, Hashable, Codable {
    case dDay = "Countdown"
    case counting = "Count Days"
            
    var content: String {
        switch self {
        case .dDay:
            return "Set a countdown date"
        case .counting:
            return "Count days from specified date"
        }
    }
    
    var dateReference: String {
        switch self {
        case .dDay:
            return "To"
        case .counting:
            return "From"
        }
    }
    
    var dateLastComment: String {
        switch self {
        case .dDay:
            return "Left"
        case .counting:
            return "Passed"
        }
    }
    
    var caption: String? {
        switch self {
        case .dDay:
            return nil
        case .counting:
            return "Include end date in calculation"
        }
    }
}
