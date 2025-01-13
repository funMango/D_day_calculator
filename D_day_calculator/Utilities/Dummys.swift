//
//  Dummys.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import Foundation

struct DayInfoDummy {
    var dummys: [DayInfo] = []
    
    init() {
        let dayInfoes: [(String, String, Mode)] = [
            ("Jeju Travel", "2025-02-07", .dDay),
            ("Seoul Travel", "2025-09-11", .dDay),
            ("Busan Travel", "2025-11-08", .dDay),
            ("Anniversary", "2023-11-18", .counting),
        ]
                        
        for info in dayInfoes {
            let title = info.0
            let targetDate = info.1
            let mode = info.2
            
            if let targetDate = createDate(from: targetDate) {
                let dayInfo = DayInfo(title: title, targetDate: targetDate, mode: mode)
                dummys.append(dayInfo)
            } else {
                print("날짜 변환 실패: \(targetDate)")
            }
        }
    }
    
    func createDate(from dateString: String, format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: dateString)
    }
}
