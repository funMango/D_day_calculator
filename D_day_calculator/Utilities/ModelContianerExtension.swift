//
//  ModelContianerExtension.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/13/25.
//

import Foundation
import SwiftData

extension ModelContainer {
    func getModelContainer() -> ModelContainer {
        do {
            let schema = Schema([TimeSpan.self])
            return try ModelContainer(
                for: schema,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)
            )
        } catch {
            fatalError("[Error] DateRepository container 시작 실패: \(error)")
        }
    }
}
