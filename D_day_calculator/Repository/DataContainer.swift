//
//  DataContainer.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/14/25.
//

import Foundation
import SwiftData


final class DataContainer {
    static let shared = DataContainer()
    var modelContainer: ModelContainer
    
    private init() {
        do {
            let schema = Schema([TimeSpan.self, User.self])
            self.modelContainer = try ModelContainer(
                for: schema,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)
            )
        } catch {
            fatalError("[Error] DateRepository container 시작 실패: \(error)")
        }
    }
}
