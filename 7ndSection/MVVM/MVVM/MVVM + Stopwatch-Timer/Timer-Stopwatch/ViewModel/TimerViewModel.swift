//
//  ViewModel.swift
//  Timer-StopWatch
//
//  Created by Sabir Myrzaev on 22.02.2022.
//

import Foundation

class TimerViewModel: TimerModelType {
    static let countSection = 3
    
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    
    private var timer: Timer? = nil
    
    var clockText = Box<String>("")

    // work with playButton for action by stopwatch
    func startStopwatch() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours += 1
                } else {
                    self.minutes += 1
                }
            } else {
                self.seconds += 1
            }
            self.clockText.value = String(format:"%02i:%02i:%02i", self.hours, self.minutes, self.seconds)
        }
        
    }
    
    // work with playButton for action by timer
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 0 && self.minutes != 0 {
                self.minutes -= 1
                self.seconds = 59
            } else if self.minutes == 0 && self.hours != 0 {
                self.hours -= 1
                self.minutes = 59
                self.seconds = 59
            } else if self.minutes == 0 && self.hours == 0 && self.seconds == 0 {
                self.timer?.invalidate()
            } else {
                self.seconds -= 1
            }
            self.clockText.value = String(format:"%02i:%02i:%02i", self.hours, self.minutes, self.seconds)
        }
    }
    
    // reset Timer.shedule
    func resetInval() -> () {
        timer?.invalidate()
        timer = nil
        hours = 0
        minutes = 0
        seconds = 0
        return self.clockText.value = String(format:"%02i:%02i:%02i", self.hours, self.minutes, self.seconds)
    }
    
    // stop Timer.shedule
    func stopCount() -> () {
        timer?.invalidate()
        return self.clockText.value = String(format:"%02i:%02i:%02i", self.hours, self.minutes, self.seconds)
    }
    
    // for display sections in datePicker
    func didSelect(row: Int, component: Int) {
        if component == 0 {
            hours = row
        } else if component == 1 {
            minutes = row
        } else {
            seconds = row
        }
    }
    
    // for display format in sections
    func numberOfRows(component: Int) -> Int {
        switch component {
        // case 0 it's hours case 1d = 24 hours
        case 0:
            return 24
        // case 1,2 it's minutes, seconds 1m = 60 seconds,
        default:
            return 60
        }
    }
    
    func formatPicker(row: Int) -> String {
        return String(format: "%02d", row)
    }
}
