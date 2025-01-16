//
//  Day.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/15/25.
//

import Foundation

class DateViewModel: ObservableObject {
    @Published var title = ""
    @Published var selectedDate = Date()
    @Published var totalDays = 0
    @Published var mode = Mode.dDay
    private var interactor: DateInteractor
    
    init(interactor: DateInteractor) {
        self.interactor = interactor
    }
                
    func selectMode(from mode: Mode) {
        self.mode = mode
        self.selectedDate = Date()
        
        switch mode {
        case .dDay:
            totalDays = 0
        case .counting:
            totalDays = 1
        }
    }
                    
    func calcDateDiff() {
        let targetDate: Date
        let referenceDate: Date
                
        switch mode {
        case .dDay:
            targetDate = selectedDate
            referenceDate = Date()
        case .counting:
            targetDate = Date()
            referenceDate = selectedDate
        }
        
        let dateContext = DateContext(
            targetDate: targetDate,
            referenceDate: referenceDate,
            timeRegion: TimeRegion.seoul
        )
        
        let result = interactor.execute(from: dateContext)
        
        switch mode {
        case .dDay:
            totalDays = result
        case .counting:
            totalDays = result + 1
        }                                        
    }
}
