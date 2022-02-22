//
//  Extension + UIPickerViewDataSource.swift
//  Timer-StopWatch
//
//  Created by Sabir Myrzaev on 22.02.2022.
//

import UIKit

// MARK: - UIPickerViewDataSource

extension TimerStopwatchViewController: UIPickerViewDataSource {
    
    // return 3 cells in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return TimerViewModel.countSection
    }
    // return rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.numberOfRows(component: component) ?? 0
    }
}
