//
//  DateDatailViewModel.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/5/25.
//

import Foundation
import SwiftData
import Combine

class DateDetailViewModel: ObservableObject {
    @Published var timeSpan: TimeSpan
    let id = UUID().uuidString
    var dateManager: DateManageProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(timeSpan: TimeSpan, dateManager: DateManageProtocol) {
        self.timeSpan = timeSpan
        self.dateManager = dateManager
        observeRepoChange()
    }
        
    func deleteDate() {
        dateManager.delete(from: self.timeSpan)
    }
    
    func fetchDate() {
        let newTimeSpan = dateManager.fetch(from: self.timeSpan)
        guard let newTimeSpan else { return }
        self.timeSpan = newTimeSpan
    }
    
    private func observeRepoChange() {
        dateManager.event
            .sink { [weak self] in
                self?.fetchDate()
            }
            .store(in: &cancellables)
    }
}
