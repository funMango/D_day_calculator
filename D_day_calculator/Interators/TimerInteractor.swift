//
//  TimerInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/29/25.
//

import Foundation

protocol TimerProtocol {
    func startTimer(now: Date, action: @escaping () -> Void)
}

class TimerInteractor: TimerProtocol {
    private var timer: DispatchSourceTimer?
    
    func startTimer(now: Date, action: @escaping () -> Void) {
        timer?.cancel() // 기존 타이머 해제
                        
        // 자정까지 남은 시간(초)
        let secondsUntilMidnight = getLeftTime(from: now)
        
        // 백그라운드에서도 실행 가능한 DispatchSourceTimer 생성
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        
        // 자정까지 기다렸다가 실행, 이후 매 24시간(86400초)마다 실행
        timer?.schedule(deadline: .now() + secondsUntilMidnight, repeating: 86400)
        
        timer?.setEventHandler {
            action()
        }
        
        timer?.resume()
    }
    
    func getLeftTime(from now: Date) -> TimeInterval {        
        let calendar = Calendar.current
        let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .strict)
        
        guard let midnight = midnight else {
            fatalError("midnigth is nil")
        }
        
        return midnight.timeIntervalSince(now)
    }
}



