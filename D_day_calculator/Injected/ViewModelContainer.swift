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
        return DateViewModel(
            dateManageInteractor: DateManageInteractor(
                dateRepository: dateRepository,
                dateCalculator: DateCalcInterator()
            ),
            dateCalcInteractor: DateCalcInterator(),
            timeSpan: timeSpan,
            mode: mode
        )
    }
    
    func getDatesViewModel() -> DatesViewModel {
        return DatesViewModel(
            dateManager: DateManageInteractor(
                dateRepository: dateRepository,
                dateCalculator: DateCalcInterator()
            ),
            dateCalculator: DateCalcInterator(),
            timer: TimerInteractor()
        )
    }
}
