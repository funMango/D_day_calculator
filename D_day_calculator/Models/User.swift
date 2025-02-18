//
//  User.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/16/25.
//

import Foundation
import SwiftData

@Model
class User: Equatable, Identifiable {
    var id = UUID().uuidString
    var isFirstLaunch = true
    
    init(isFirstLaunch: Bool = true) {
        self.isFirstLaunch = isFirstLaunch
    }
}
