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
    func updateDate(from timeSpan: TimeSpan)
}

class DateRepository: DateRepoProtocol {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    var event = PassthroughSubject<Void, Never>()
    
    @MainActor
    init() {
        do {
            self.modelContainer = try ModelContainer(
                for: TimeSpan.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false)
            )
            self.modelContext = modelContainer.mainContext            
        } catch {
            fatalError("[Error] DateRepository container 시작 실패: \(error)")
        }
    }
    
    func saveDate(from timeSpan: TimeSpan) {
        modelContext.insert(timeSpan)
                
        do {
            try modelContext.save()
            print("💾 timeSpan 저장완료 (id: \(timeSpan.id), title: \(timeSpan.title)")
            event.send()
        } catch {
            print("[Error] timeSpan 저장실패: \(error)")
        }
    }
    
    func deleteDate(from timeSpan: TimeSpan) {
        do {
            let fetchedTimeSpans = fetchDate()
            
            if let timeSpanToDelete = fetchedTimeSpans.first(where: { $0.id == timeSpan.id }) {
                modelContext.delete(timeSpanToDelete)
                try modelContext.save()
                event.send()
                print("⚠️ timeSpan 삭제완료 (id: \(timeSpan.id), title: \(timeSpan.title))")
            } else {
                print("[Error] 해당 timeSpan을 찾을 수 없습니다 (id: \(timeSpan.id), title: \(timeSpan.title)")
            }
        } catch {
            print("[Error] timeSpan 삭제실패: \(error)")
        }
    }
    
    func updateDate(from timeSpan: TimeSpan) {
        do {
            let fetchedTimeSpans = fetchDate()
            
            if let existingTimeSpan = fetchedTimeSpans.first(where: { $0.id == timeSpan.id }) {
                existingTimeSpan.title = timeSpan.title
                existingTimeSpan.selectedDate = timeSpan.selectedDate
                existingTimeSpan.today = timeSpan.today
                existingTimeSpan.mode = timeSpan.mode
                existingTimeSpan.calculatedDays = timeSpan.calculatedDays
                existingTimeSpan.days = timeSpan.days
                
                try modelContext.save()
                event.send()
                print("✅ timeSpan 업데이트 완료 (id: \(timeSpan.id), title: \(timeSpan.title))")
            } else {
                print("[Error] 해당 timeSpan을 찾을 수 없습니다 (id: \(timeSpan.id), title: \(timeSpan.title))")
            }
        } catch {
            print("[Error] timeSpan 업데이트 실패: \(error)")
        }
    }
    
    func fetchDate() -> [TimeSpan] {
        do {
            let descriptor = FetchDescriptor<TimeSpan>()
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError("[Error] timeSpan배열 fetch 실패: \(error)")
        }
    }
}

// MARK: - data migration
extension DateRepository {
    private func migration() {
        let fetchDescripter = FetchDescriptor<TimeSpan>()
        
        do {
            let oldData = try modelContext.fetch(fetchDescripter)
            
            for data in oldData {
                let newItem = TimeSpan(
                    id: data.id,
                    createdDate: data.createdDate,
                    title: data.title,
                    selectedDate: data.selectedDate,
                    today: data.today,
                    mode: data.mode,
                    calculatedDays: data.calculatedDays,
                    days: 0
                )
                modelContext.delete(data)
                modelContext.insert(newItem)
            }
            
            try modelContext.save()
                                                            
        } catch(let error) {
            print(error)
        }
    }
}
