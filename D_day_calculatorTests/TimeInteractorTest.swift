//
//  TimeInteractorTest.swift
//  D_day_calculatorTests
//
//  Created by 이민호 on 2/5/25.
//

import XCTest
import D_day_calculator

final class TimeInteractorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let timer = TimerInteractor()
        let now = Date.getDate(year: 2024, month: 02, day: 10, hour: 23, minute: 58, second: 30)
        let result = timer.getLeftTime(from: now)
        XCTAssertEqual(result, 90.0)
    }
}
