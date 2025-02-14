//
//  ViewModelContainer.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/24/25.
//

import Foundation

class ViewModelContainer: ObservableObject {
    var dateRepository: DateRepository
    
    init(dateRepository: DateRepository) {
        self.dateRepository = dateRepository
    }
    
    func getDateViewModel(mode: Mode, timeSpan: TimeSpan? = nil) -> DateViewModel {
        return DateViewModel(
            dateManageInteractor: getDateManageInteractor(),
            dateCalcInteractor: DateCalcInterator(),
            timeSpan: timeSpan,
            mode: mode
        )
    }
    
    func getDatesViewModel() -> DatesViewModel {
        return DatesViewModel(
            dateManager: getDateManageInteractor(),
            dateCalculator: DateCalcInterator(),
            timer: TimerInteractor()
        )
    }
    
    func getDateDetailViewModel(timeSpan: TimeSpan) -> DateDetailViewModel {
        return DateDetailViewModel(
            timeSpan: timeSpan,
            dateManager: getDateManageInteractor()
        )
    }
    
    private func getDateManageInteractor() -> DateManageInteractor {
        return DateManageInteractor(
            dateRepository: dateRepository,
            dateCalculator: DateCalcInterator()
        )
    }
}

extension ViewModelContainer {
    @MainActor static func getViewModelContainer() -> ViewModelContainer {
        return ViewModelContainer(
            dateRepository: DateRepository(
                modelContainer: DataContainer.shared.getModelContainer()
            )
        )
    }
}
