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
    func delete(from timeSpan: TimeSpan)
    func update(from timeSpan: TimeSpan)
}

class DateManageInteractor: DateManageProtocol{
    private let dateRepository: DateRepoProtocol
    private var cancellables = Set<AnyCancellable>()
    var event = PassthroughSubject<Void, Never>()
    
    init(dateManageService: DateRepoProtocol) {
        self.dateRepository = dateManageService
        observeRepoChange()
    }
    
    func save(from timeSpan: TimeSpan) {
        dateRepository.saveDate(from: timeSpan)                      
    }
               
    func fetch() -> [TimeSpan] {
        return dateRepository.fetchDate()
    }
    
    func delete(from timeSpan: TimeSpan) {
        dateRepository.deleteDate(from: timeSpan)
    }
    
    func update(from timeSpan: TimeSpan) {
        dateRepository.updateDate(from: timeSpan)
    }
    
    private func observeRepoChange() {
        dateRepository.event
            .sink { [weak self] in                
                self?.event.send()
            }
            .store(in: &cancellables)
    }
}
