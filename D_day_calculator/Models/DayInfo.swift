//
//  DayInfo.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import Foundation
import SwiftData

@Model
class DayInfo: Hashable {
    @Attribute(.unique) var id = UUID().uuidString
    var title: String
    var targetDate: Date
    @Attribute var modeRaw: String
    var mode: Mode {
        get {
            return Mode(rawValue: modeRaw) ?? .dDay // 기본값을 .dDay로 설정
        }
        set {
            modeRaw = newValue.rawValue // Mode를 String으로 변환하여 저장
        }
    }
    var result: String?
    
    init(title: String, targetDate: Date, mode: Mode) {
        self.title = title
        self.targetDate = targetDate
        self.modeRaw = mode.rawValue
    }
    
    func getTargetDate() -> String {
        return Convertor.convertToDate(date: targetDate, format: "yyyy.MM.dd")
    }
}
