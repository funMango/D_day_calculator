//
//  DateInfoInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData

protocol DateRepoProtocol {
    func execute(action: DateAction, from timeSpan: TimeSpan)
}

enum DateAction {
    case save
}

class DateRepository: DateRepoProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = DateRepository()
    
    @MainActor
    private init() {
        do {
            self.modelContainer = try ModelContainer(
                for: TimeSpan.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false)
            )
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to initialize model container: \(error)")
        }
    }
        
    func execute(action: DateAction, from timeSpan: TimeSpan) {
        switch action {
        case .save:
            saveDate(from: timeSpan)
        }
    }
    
    private func saveDate(from timeSpan: TimeSpan) {
        modelContext.insert(timeSpan)
        
        Task {
            do {
                try modelContext.save()
                print("timeSpan 저장완료")
            } catch {
                print("timeSpan 저장실패: \(error)")
            }
        }
    }
}
