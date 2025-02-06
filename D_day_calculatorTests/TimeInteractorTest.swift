//
//  TimeInteractorTest.swift
//  D_day_calculatorTests
//
//  Created by 이민호 on 2/5/25.
//

import XCTest
import D_day_calculator

final class TimeInteractorTest: XCTestCase {
    var timerInteractor: TimerInteractor!
        
    override func setUp() {
        super.setUp()
        timerInteractor = TimerInteractor()
    }

    override func tearDown() {
        timerInteractor = nil
        super.tearDown()
    }

    func testStartTimer_ExecutesActionAtMidnight() {
        let expectation = self.expectation(description: "타이머가 자정에 실행됨")
        let now = Date()
                
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let testMidnight = now.addingTimeInterval(1)
            self.timerInteractor.startTimer(now: now, midnight: testMidnight) { nextDay in
                print("✅ 테스트 타이머 실행!")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3) // 2초 이내에 실행되면 성공
    }
}
