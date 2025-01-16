//
//  DateDiffInteractorTest.swift
//  D_day_calculatorTests
//
//  Created by 이민호 on 1/16/25.
//

import XCTest

final class DateDiffInteractorTest: XCTestCase {
    private var calendar = Calendar.current
    private let interactor = DateDiffInteractor()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_execute_dateDiff() throws {
        // Given
        let testCases: [(targetDate: DateComponents, today: DateComponents, expected: Int)] = [
            // same date
            (DateComponents(year: 2025, month: 2, day: 14), DateComponents(year: 2025, month: 2, day: 14), 0),
            
            // day diff
            (DateComponents(year: 2025, month: 2, day: 14), DateComponents(year: 2025, month: 2, day: 13), -1),
            
            // month diff
            (DateComponents(year: 2025, month: 3, day: 14), DateComponents(year: 2025, month: 2, day: 13), -29),
            
            // year diff
            (DateComponents(year: 2025, month: 3, day: 14), DateComponents(year: 2024, month: 2, day: 13), -395),
            (DateComponents(year: 2023, month: 11, day: 18), DateComponents(year: 2025, month: 1, day: 16), 425),
        ]
        
        for testCase in testCases {
            guard
                let targetDate = calendar.date(from: testCase.targetDate),
                let today = calendar.date(from: testCase.today)
            else {
                XCTFail("Invalid Test Case: \(testCase)")
                continue
            }
            
            let dateContext = DateContext(
                targetDate: targetDate,
                referenceDate: today,
                timeRegion: TimeRegion.seoul
            )
                        
            let result = interactor.execute(from: dateContext)
            XCTAssertEqual(result, testCase.expected, "Fail: \(testCase)")
        }
    }
}
