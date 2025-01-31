//
//  ViewModelContainer.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/24/25.
//

import Foundation

class ViewModelContainer: ObservableObject {
    var dateRepository: DateRepoProtocol
    
    init(dateRepository: DateRepoProtocol) {
        self.dateRepository = dateRepository
    }
    
    func getDateViewModel(mode: Mode, timeSpan: TimeSpan? = nil) -> DateViewModel {
        switch mode {
        case .dDay:
            return DateViewModel(
                dateManageInteractor: DateManageInteractor(
                    dateManageService: dateRepository),
                dateCalcInteractor: DdayCalcInterator(),
                timeSpan: timeSpan,
                mode: mode
            )
        case .counting:
            return DateViewModel(
                dateManageInteractor: DateManageInteractor(
                    dateManageService: dateRepository),
                dateCalcInteractor: CountingCalcInterator(),
                timeSpan: timeSpan,
                mode: mode
            )
        }
    }
    
    func getDatesViewModel() -> DatesViewModel {
        return DatesViewModel(
            dateManager: DateManageInteractor(
                dateManageService: dateRepository
            )
        )
    }
}
