//
//  DatesViewModels.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/21/25.
//

import Foundation
import SwiftData
import Combine

class DatesViewModels: ObservableObject {
    @Published var dates: [TimeSpan] = []
    var dateManager: DateManageProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(dateManager: DateManageProtocol) {
        self.dateManager = dateManager
        fetchDates()
        observeRepoChange()
    }
    
    private func fetchDates() {
        self.dates = dateManager.fetch()
    }
    
    private func observeRepoChange() {
        dateManager.event
            .sink { [weak self] in                
                self?.fetchDates()
            }
            .store(in: &cancellables)
    }
}

