//
//  Day.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/15/25.
//

import Foundation
import SwiftData

class DateViewModel: ObservableObject {
    @Published var mode: Mode?
    @Published var title = ""
    @Published var selectedDate = Date()
    @Published var calculatedDays = ""
    var calcInteractor: DateCalcProtocol?
    var dateManageInteractor: DateManageProtocol
    
    init(dateManageInteractor: DateManageProtocol) {
        self.dateManageInteractor = dateManageInteractor
    }
    
    func set(mode: Mode, calcInteractor: DateCalcProtocol) {
        self.mode = mode
        self.calcInteractor = calcInteractor
        reset()
        calcDateDiff()
    }
    
    private func reset() {
        self.title = ""
        self.selectedDate = Date()
    }
            
    func calcDateDiff() {
        if let calcInteractor = calcInteractor, let mode = mode {
            let dateContext = DateContext(
                startDate: self.selectedDate,
                endDate: Date(),
                mode: mode
            )
            
            calculatedDays = calcInteractor.execute(from: dateContext)
        } else {
            print("calcInteractor, mode binding error!")
        }
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
