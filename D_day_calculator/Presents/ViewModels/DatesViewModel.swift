//
//  DatesViewModels.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/21/25.
//

import Foundation
import SwiftData
import Combine
import SwiftUI

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
        
        fetchDates()
        observeRepoChange()
    }
    
    func deleteDate(from offsets: IndexSet) {
        for index in offsets {
            let target = dates[index]
            dateManager.delete(from: target)
        }
    }
    
    func handleScenePhaseChange(_ newPhase: ScenePhase) {
        switch newPhase {
        case .active:
            print("🔔 앱이 Foreground로 변경됨! 🚀")
            updateTime()
            updateDates()
        case .inactive:
            print("⏸️ 앱이 Inactive 상태 (일시정지됨)")
        case .background:
            print("🌙 앱이 Background로 변경됨! 💤")
        @unknown default:
            print("⚠️ scenePhase의 새로운 상태가 감지됨: \(newPhase)")
        }
    }
        
    func updateTime() {
        let now = Date()
        let midnight = Date.midnight(from: now)
        
        print("타이머 now 시간: \(now.getString())")
        print("타이머 midnigth 시간: \(midnight.getString())")
        
        timer.startTimer(now: now, midnight: midnight) { nextDay in
            print("⏱️ 타이머 시작: \(Date().getString()), 다음날: \(nextDay.getString())")
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

