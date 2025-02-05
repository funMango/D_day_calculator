//
//  NavigationPath.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/17/25.
//

import Foundation
import SwiftUI

enum NavigationTarget: Hashable {
    case modeSelection
    case datePicker(viewModel: DateViewModel, type: DatePickerViewType)
    case dateDetail(viewModel: DateDetailViewModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .modeSelection:
            hasher.combine(0)
        case .datePicker(let viewModel, let type):
            hasher.combine(viewModel.id)
            hasher.combine(type)
        case .dateDetail(let viewModel):
            hasher.combine(viewModel.id)
        }
    }

    static func == (lhs: NavigationTarget, rhs: NavigationTarget) -> Bool {
        switch (lhs, rhs) {
        case (.modeSelection, .modeSelection):
            return true
        case (.datePicker(let lhsViewModel, let lhsType), .datePicker(let rhsViewModel, let rhsType)):
            return lhsViewModel.id == rhsViewModel.id && lhsType == rhsType            
        case (.dateDetail(let lhsViewModel), .dateDetail(let rhsViewModel)):
            return lhsViewModel.id == rhsViewModel.id
        default:
            return false
        }
    }
}

class NavigationPathObject: ObservableObject {
    @Published var path = NavigationPath()
    
    func clear() {
        path = NavigationPath()
    }
    
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
