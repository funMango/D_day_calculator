//
//  Day.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/15/25.
//

import Foundation
import SwiftData

class DateViewModel: ObservableObject, Hashable {
    @Published var title = ""
    @Published var selectedDate = Date()
    @Published var mode = Mode.dDay
    @Published var calculatedDays = ""
    var id = UUID().uuidString
    private var timsSpanId: String?
    private var createdDate = Date.today()
    private var days = 0
    
            
    var dateCalcInteractor: DateCalcProtocol
    var dateManageInteractor: DateManageProtocol
    
    init(dateManageInteractor: DateManageProtocol,
         dateCalcInteractor: DateCalcProtocol,
         timeSpan: TimeSpan? = nil,
         mode: Mode? = nil
    ) {
        self.dateManageInteractor = dateManageInteractor
        self.dateCalcInteractor = dateCalcInteractor
        
        // 새로 만들때
        if let mode = mode {
            self.mode = mode
        }
        
        // 수정할때
        if let timeSpan = timeSpan {
            setDate(from: timeSpan)
        }
        
        calcDateDiff()
    }
}

// MARK: - setter
extension DateViewModel {
    func setMode(from mode: Mode) {
        self.mode = mode
    }
    
    private func setDate(from timeSpan: TimeSpan) {
        self.timsSpanId = timeSpan.id
        self.createdDate = timeSpan.createdDate
        self.title = timeSpan.title
        self.selectedDate = timeSpan.selectedDate        
        self.mode = timeSpan.mode
        self.calculatedDays = timeSpan.calculatedDays
        self.days = timeSpan.days ?? 0
    }
}

// MARK: - Date Calculate
extension DateViewModel {
    func calcDateDiff() {
        let dateContext = DateContext(
            startDate: self.selectedDate,
            endDate: Date(),
            mode: mode
        )
        
        self.calculatedDays = dateCalcInteractor.calcToString(
            mode: mode,
            dateContext: dateContext
        )
        
        self.days = dateCalcInteractor.calcToInt(mode: mode, dateContext: dateContext)
    }
}

// MARK: - CRUD
extension DateViewModel {
    func saveDate() {
        let timeSpan = getTimeSpan()
        dateManageInteractor.save(from: timeSpan)
    }
    
    func updateDate() {
        let timeSpan = getTimeSpan()
        dateManageInteractor.update(from: timeSpan)
    }
    
    private func getTimeSpan() -> TimeSpan {
        return TimeSpan(
            id: self.id,
            createdDate: self.createdDate,
            title: self.title,
            selectedDate: self.selectedDate,
            today: Date.today(),
            mode: mode,
            calculatedDays: self.calculatedDays,
            days: self.days
        )
    }
}

// MARK: - Hashable
extension DateViewModel {
    static func == (lhs: DateViewModel, rhs: DateViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
