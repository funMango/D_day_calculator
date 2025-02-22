//
//  Policy.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/22/25.
//

import Foundation

enum Policy {
    case privacy
    case terms
    
    var url: String {
        switch self {
        case .privacy:
            return "https://stingy-llama-a98.notion.site/Privacy-policy-19ad45242c9b80288d33d989bc959c0d"
        case .terms:
            return "https://stingy-llama-a98.notion.site/Terms-of-service-1a2d45242c9b80fcb754f163a6ce66b6?pvs=73"
        }
    }
}
