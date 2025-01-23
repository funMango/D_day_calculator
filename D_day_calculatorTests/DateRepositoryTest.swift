//
//  DateRepositoryTest.swift
//  D_day_calculatorTests
//
//  Created by 이민호 on 1/23/25.
//

import XCTest

final class DateRepositoryTest: XCTestCase {
    @MainActor var dateRepository = DateRepository.shared
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func test_save() throws {
        // Given
        let timeSpan = TimeSpan(
            title: "example",
            startDate: Date(),
            endDate: Date(),
            mode: .dDay,
            calculatedDays: "D-day"
        )
        
        // When
        dateRepository.saveDate(from: timeSpan)
        
        // Then
        let expected = dateRepository.fetchDate().filter { $0.id == timeSpan.id }
        
        guard !expected.isEmpty else {
            return XCTFail("Not Found")
        }
        
        XCTAssertEqual(expected.first, timeSpan)
        dateRepository.deleteDate(from: timeSpan)
    }
    
    @MainActor
    func test_delete() throws {
        // Given
        let timeSpan = TimeSpan(
            title: "example",
            startDate: Date(),
            endDate: Date(),
            mode: .dDay,
            calculatedDays: "D-day"
        )
        
        // When
        dateRepository.saveDate(from: timeSpan)
        
        // Then
        dateRepository.deleteDate(from: timeSpan)
        let fetched = dateRepository.fetchDate().filter { $0.id == timeSpan.id }
                
        XCTAssertTrue(fetched.isEmpty)
    }
    
    @MainActor
    func test_update_title() throws {
        // Given
        let id = UUID().uuidString
        
        let timeSpan = TimeSpan(
            id: id,
            title: "example",
            startDate: Date(),
            endDate: Date(),
            mode: .dDay,
            calculatedDays: "D-day"
        )
        
        let testCases: [TimeSpan] = [
            TimeSpan(
                id: id,
                title: "example1",
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 14))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 14))!,
                mode: .counting,
                calculatedDays: "1 day"
            ),
            
            TimeSpan(
                id: id,
                title: "example2",
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2025, month: 12, day: 31))!,
                mode: .counting,
                calculatedDays: "365 days"
            ),
            
            TimeSpan(
                id: id,
                title: "example3",
                startDate: Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 15))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 15))!,
                mode: .dDay,
                calculatedDays: "365 days"
            ),
            
            TimeSpan(
                id: id,
                title: "example4",
                startDate: Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 10))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 15))!,
                mode: .counting,
                calculatedDays: "5 days"
            ),
            
            TimeSpan(
                id: id,
                title: "example5",
                startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 31))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1))!,
                mode: .dDay,
                calculatedDays: "1 day"
            ),
            
            TimeSpan(
                id: id,
                title: "example6",
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 1))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 1))!,
                mode: .counting,
                calculatedDays: "1 day"
            )
        ]
        
        // When
        dateRepository.saveDate(from: timeSpan)
        
        // Then
        for testCase in testCases {
            dateRepository.updateDate(from: testCase)
            let fetched = dateRepository.fetchDate().filter { $0.id == testCase.id }
                        
            if let fetchedFirst = fetched.first {
                XCTAssertEqual(fetchedFirst, testCase)
            } else {
                XCTFail("[Error] 해당되는 timeSpan을 찾을 수 없습니다. (id: \(testCase.id), title: \(testCase.title)")
            }
        }
        
        dateRepository.deleteDate(from: timeSpan)
    }
}
