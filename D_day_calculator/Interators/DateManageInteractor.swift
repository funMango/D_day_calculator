//
//  DateManageInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/21/25.
//

import Foundation

protocol DateManageProtocol {
    func execute(action: DateAction, from timeSpan: TimeSpan)
}


class DateManageInteractor: DateManageProtocol{
    private let dateRepository: DateRepoProtocol
    
    init(dateManageService: DateRepoProtocol) {
        self.dateRepository = dateManageService
    }
        
    func execute(action: DateAction, from timeSpan: TimeSpan) {
        dateRepository.execute(action: action, from: timeSpan)
    }
}
