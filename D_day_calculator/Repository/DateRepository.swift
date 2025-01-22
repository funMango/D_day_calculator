//
//  DateInfoInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/20/25.
//

import Foundation
import SwiftData
import Combine

protocol DateRepoProtocol {
    var event: PassthroughSubject<Void, Never> { get }
    func saveDate(from timeSpan: TimeSpan)
    func fetchDate() -> [TimeSpan]
    func deleteDate(from timeSpan: TimeSpan)
}

enum DateAction {
    case save
}

enum SortAction {
    case createdAtDescending
    case createdAtAscending
}

enum FilterAction {
    case title
    case startDate
    case mode
    case createdDate
}

class DateRepository: DateRepoProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    var event = PassthroughSubject<Void, Never>()
    
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
    
    func saveDate(from timeSpan: TimeSpan) {
        modelContext.insert(timeSpan)
                
        do {
            try modelContext.save()
            print("timeSpan 저장완료 (id: \(timeSpan.id), title: \(timeSpan.title)")
            event.send()
        } catch {
            print("timeSpan 저장실패: \(error)")
        }
    }
    
    func deleteDate(from timeSpan: TimeSpan) {
        self.modelContext.delete(timeSpan)
        
        do {
            try modelContext.save()
            print("timeSpan 삭제완료 (id: \(timeSpan.id), title: \(timeSpan.title)")
            event.send()
        } catch {
            print("timeSpan 삭제실패")
        }
    }
    
    func fetchDate() -> [TimeSpan] {
        do {
            let descriptor = FetchDescriptor<TimeSpan>()
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError("[Error]: Failed to fetch timeSpans: \(error)")
        }
    }
}
