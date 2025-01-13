//
//  Convertor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import Foundation

struct Convertor {
    static func convertToDate(date: Date, format: String = "yyyy.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
