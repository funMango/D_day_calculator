//
//  DateManageInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/21/25.
//

import Foundation
import Combine

protocol DateManageProtocol {
    var event: PassthroughSubject<Void, Never> { get }
    func save(from timeSpan: TimeSpan)
    func fetch() -> [TimeSpan]
    func fetch(from timeSpan: TimeSpan) -> TimeSpan?
    func delete(from timeSpan: TimeSpan)
    func update(from timeSpan: TimeSpan)
    func updateAll(from timeSpans: [TimeSpan], to targetDate: Date)
}

class DateManageInteractor: @preconcurrency DateManageProtocol{
    private let dateRepository: DateRepoProtocol
    private let dateCalculator: DateCalcProtocol
    private var cancellables = Set<AnyCancellable>()
    var event = PassthroughSubject<Void, Never>()
    
    init(dateRepository: DateRepoProtocol, dateCalculator: DateCalcProtocol) {
        self.dateRepository = dateRepository
        self.dateCalculator = dateCalculator
        observeRepoChange()
    }
    
    func save(from timeSpan: TimeSpan) {
        dateRepository.saveDate(from: timeSpan)                      
    }
        
    func fetch() -> [TimeSpan] {
        return dateRepository.fetchDate()
    }
        
    func fetch(from timeSpan: TimeSpan) -> TimeSpan? {
        let fetched = fetch()
        return fetched.filter { $0.id == timeSpan.id }.first
    }
    
    func delete(from timeSpan: TimeSpan) {
        dateRepository.deleteDate(from: timeSpan)
    }
    
    func deleteAll(from timeSpans: [TimeSpan]) {
        for timeSpan in timeSpans {
            delete(from: timeSpan)
        }
    }
    
    @MainActor
    func update(from timeSpan: TimeSpan) {
        dateRepository.updateDate(from: timeSpan)
    }
    
    @MainActor
    func updateAll(from timeSpans: [TimeSpan], to targetDate: Date) {
        for timeSpan in timeSpans {
            let updated = getUpdatedDate(from: timeSpan, to: targetDate)
            update(from: updated)
        }
    }
            
    private func getUpdatedDate(from timeSpan: TimeSpan, to targetDate: Date) -> TimeSpan {
        let dateContext = DateContext(
            startDate: timeSpan.selectedDate,
            endDate: targetDate,
            mode: timeSpan.mode
        )
        let calculatedDays = dateCalculator.calcToString(mode: timeSpan.mode, dateContext: dateContext)
        let days = dateCalculator.calcToInt(mode: timeSpan.mode, dateContext: dateContext)
        timeSpan.update(today: targetDate, calculatedDays: calculatedDays, days: days)
        return timeSpan
    }
    
    private func observeRepoChange() {
        dateRepository.event
            .sink { [weak self] in                
                self?.event.send()
            }
            .store(in: &cancellables)
    }
}
