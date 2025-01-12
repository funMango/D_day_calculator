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
        let dayInfoes: [(String, String ,String)] = [
            ("Jeju Travel", "2024-07-08", "2024-08-11"),
            ("Seoul Travel", "2024-09-11", "2024-10-11"),
            ("Busan Travel", "2024-11-08", "2024-12-11"),
        ]
                        
        for info in dayInfoes {
            let title = info.0
            let startDate = info.1
            let dDay = info.2
            
            if let startDate = createDate(from: startDate), let dDay = createDate(from: dDay) {
                let dayInfo = DayInfo(title: title, startDay: startDate, endDate: dDay)
                dummys.append(dayInfo)
            } else {
                print("날짜 변환 실패: \(startDate)또는 \(dDay)")
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
