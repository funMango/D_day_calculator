//
//  Day.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/15/25.
//

import Foundation
import SwiftData

class DateViewModel: ObservableObject {
    @Published var title = ""
    @Published var selectedDate = Date()
    @Published var mode: Mode?
    @Published var calculatedDays = ""
    private var id: String?
    private var createdDate: Date?
    
    var dateCalcInteractor: DateCalcProtocol
    var dateManageInteractor: DateManageProtocol
    
    init(dateManageInteractor: DateManageProtocol,
         dateCalcInteractor: DateCalcProtocol,
         timeSpan: TimeSpan? = nil,
         mode: Mode? = nil
    ) {
        self.dateManageInteractor = dateManageInteractor
        self.dateCalcInteractor = dateCalcInteractor
        
        if let mode = mode {
            self.mode = mode
        }
        
        if let timeSpan = timeSpan {
            setDate(from: timeSpan)
        }
        
        calcDateDiff()
    }
            
    private func setDate(from timeSpan: TimeSpan) {
        self.id = timeSpan.id
        self.createdDate = timeSpan.createdDate
        self.title = timeSpan.title
        self.selectedDate = timeSpan.startDate
        self.mode = timeSpan.mode
        self.calculatedDays = timeSpan.calculatedDays
    }
            
    func calcDateDiff() {
        guard let mode = mode else {
            fatalError("[Error]: mode가 선택되지 않았습니다.")
        }
                        
        let dateContext = DateContext(
            startDate: self.selectedDate,
            endDate: Date(),
            mode: mode
        )
        
        calculatedDays = dateCalcInteractor.execute(from: dateContext)
    }
    
    func saveDate() {
        let timeSpan = getTimeSpan()
        dateManageInteractor.save(from: timeSpan)
    }
    
    private func getTimeSpan() -> TimeSpan {
        guard let mode = self.mode else {
            fatalError("[Error]: mode가 선택되지 않았습니다.")
        }
        
        return TimeSpan(
            title: self.title,
            startDate: self.selectedDate,
            endDate: Date(),
            mode: mode,
            calculatedDays: self.calculatedDays
        )
    }
}
