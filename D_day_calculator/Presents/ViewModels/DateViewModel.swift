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
    
    func set(mode: Mode, calcInteractor: DateCalcProtocol) {
        self.mode = mode
        self.calcInteractor = calcInteractor
        reset()        
    }
    
    private func reset() {
        self.title = ""
        self.selectedDate = Date()
        self.calculatedDays = mode?.rawValue ?? ""
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
}
