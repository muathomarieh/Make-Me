//
//  PomodoroTimeManager.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import Foundation
import Observation

enum PomodoroTimerState: String {
    case idle
    case running
    case paused
}

enum PomodoroTimerMode: String {
    case work
    case pause
}

@Observable
class PomodoroTimer {
    // timer -> tick every second
    // properties -> how many seconds left / passed
    //           -> fraction 0-1
    //          -> String ... 10.42
    // methods -> play, pause, resume, reset, skip
    // hepler functions
    
    private var _mode: PomodoroTimerMode = .work
    private var _state: PomodoroTimerState = .idle
    
    private var durationWork: TimeInterval
    private var durationBreak: TimeInterval
    
    private var _secondsPassed: Int = 0
    private var _fractionPassed: Double = 0
    private var dateStarted: Date = Date.now
    private var secondPassedBeforePause: Int = 0
    
    private var timer: Timer?
    
    init(workInSeconds: TimeInterval, breakInSeconds: TimeInterval) {
        durationWork = workInSeconds
        durationBreak = breakInSeconds
    }
    
    // MARK: COMPUTED PROPERTIES
    
    var secondsPassed: Int {
        return _secondsPassed
    }
    var secondsPassedString: String {
        return formatSeconds(_secondsPassed)
    }
    
    var secondsLeft: Int {
        Int(duration) - _secondsPassed
    }
    var secondsLeftString: String {
        return formatSeconds(secondsLeft)
    }
    
    var fractionPassed: Double {
        return _fractionPassed
    }
    var fractionLeft: Double {
        return 1.0 - _fractionPassed
    }
    
    var mode: PomodoroTimerMode {
        _mode
    }
    var state: PomodoroTimerState {
        _state
    }
    
    private var duration: TimeInterval {
        if _mode == .work {
            durationWork
        } else {
            durationBreak
        }
    }
    
    // MARK: PUBLIC METHODS
    func start() {
        dateStarted = Date.now
        _secondsPassed = 0
        _fractionPassed = 0
        _state = .running
        createTimer()
    }
    
    func resume() {
        dateStarted = Date.now
        _state = .running
        createTimer()
    }
    
    func pause() {
        secondPassedBeforePause = _secondsPassed
        _state = .paused
        killTimer()
    }
    
    func reset() {
        _secondsPassed = 0
        _fractionPassed = 0
        secondPassedBeforePause = 0
        _state = .idle
        killTimer()
    }
    
    func skip() {
        if  _mode == .work {
            _mode = .pause
        } else {
            _mode = .work
        }
    }
    
    // MARK: PRIVATE METHODS
    private func createTimer() {
        // schedule notification
        NotificationManager.instance.schedulePomodoroNotification(seconds: TimeInterval(secondsLeft))
        // create timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.onTick()
        }
    }
    
    private func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func onTick() {
        // calculate the seconds since start date
        let secondsSinceStartDate = Date.now.timeIntervalSince(dateStarted)
        // add the seconds before paused (if any)
        _secondsPassed = Int(secondsSinceStartDate) + secondPassedBeforePause
        // calculate fraction
        _fractionPassed = Double(_secondsPassed) / duration
        // play tick sound
        // done? play sound, reset, switch(work->pause->work), reset
        if secondsLeft == 0 {
            _fractionPassed = 0
            skip()
            reset()
            // play ending sound
            
        }
    }
    
    private func formatSeconds(_ seconds: Int) -> String {
        if seconds <= 0 {
            return "00:00"
        }
        let hh: Int = seconds / 3600
        let mm: Int = (seconds / 60)
        let ss: Int = seconds % 60 % 3600
        
        if hh > 0 {
            return String(format: "%02d:%02d:%02d", hh, mm, ss)
        } else {
            return String(format: "%02d:%02d", mm, ss)
        }
    }
}
