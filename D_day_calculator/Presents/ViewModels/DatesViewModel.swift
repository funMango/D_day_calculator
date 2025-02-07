//
//  DatesViewModels.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/21/25.
//

import Foundation
import SwiftData
import Combine

class DatesViewModel: ObservableObject {
    @Published var dates: [TimeSpan] = []
    private var dateManager: DateManageProtocol
    private var dateCalculator: DateCalcProtocol
    private var timer: TimerProtocol
    private var cancellables = Set<AnyCancellable>()
        
    init(dates: [TimeSpan] = [], dateManager: DateManageProtocol, dateCalculator: DateCalcProtocol, timer: TimerProtocol) {
        self.dates = dates
        self.dateManager = dateManager
        self.dateCalculator = dateCalculator
        self.timer = timer
        
        updateTime()
        fetchDates()
        observeRepoChange()
    }
    
    func deleteDate(from offsets: IndexSet) {
        for index in offsets {
            let target = dates[index]
            dateManager.delete(from: target)
        }
    }
        
    func updateTime() {
        let now = Date()
        
        timer.startTimer(now: now, midnight: Date.midnight()) { nextDay in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                updateDates(to: nextDay)
            }
        }
    }
    
    func updateDates(to targetDate: Date = Date.today()) {
        self.dateManager.updateAll(from: dates, to: targetDate)
    }
    
    private func fetchDates() {
        self.dates = dateManager.fetch().sorted(by: { $0.days ?? 0 < $1.days ?? 0})
    }
        
    private func observeRepoChange() {
        dateManager.event
            .sink { [weak self] in                
                self?.fetchDates()
            }
            .store(in: &cancellables)
    }
}

