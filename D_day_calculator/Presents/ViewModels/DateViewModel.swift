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
    @Published var totalDays = ""
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
            totalDays = "D-day"
        case .counting:
            totalDays = "1 days"
        }
    }
                    
    func calcDateDiff() {
        let targetDate = selectedDate
        let referenceDate = Date()
        
        let dateContext = DateContext(
            targetDate: targetDate,
            today: referenceDate,
            mode: mode,
            timeRegion: TimeRegion.seoul
        )
        
        totalDays = interactor.execute(from: dateContext)
                      
    }
}
