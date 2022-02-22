//
//  TimerModelType.swift
//  Timer-StopWatch
//
//  Created by Sabir Myrzaev on 22.02.2022.
//

import Foundation

protocol TimerModelType: AnyObject {
    func startStopwatch()
    func startTimer()
    
    func stopCount() -> ()
    func resetInval() -> ()
    
    func didSelect(row: Int, component: Int)
    func formatPicker(row: Int) -> String
    func numberOfRows(component: Int) -> Int
    
    var clockText: Box<String> { get set }
    
}
