//
//  TimerInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/29/25.
//

import Foundation

protocol TimerProtocol {
    func startTimer(now: Date, midnight: Date, action: @escaping (_ nextDay: Date) -> Void)
}

class TimerInteractor: TimerProtocol {
    private var timer: DispatchSourceTimer?
    
    func startTimer(now: Date, midnight: Date, action: @escaping (_ nextDay: Date) -> Void) {
        timer?.cancel() // 기존 타이머 해제
                
        // 자정까지 남은 시간(초)
        let secondsUntilMidnight = midnight.timeIntervalSince(now)
        print("현재시간: \(now.getString()), \(secondsUntilMidnight)초 후에 업데이트")
        
        // 백그라운드에서도 실행 가능한 DispatchSourceTimer 생성
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        
        // 자정까지 기다렸다가 실행, 이후 매 24시간(86400초)마다 실행
        timer?.schedule(deadline: .now() + secondsUntilMidnight, repeating: 86400)
        
        timer?.setEventHandler {            
            action(Date.today())
        }
        
        timer?.resume()
    }
}



