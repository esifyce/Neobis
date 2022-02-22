//
//  Extension + UIPickerViewDelegate.swift
//  Timer-StopWatch
//
//  Created by Sabir Myrzaev on 22.02.2022.
//

import UIKit

// MARK: - UIPickerViewDelegate

extension TimerStopwatchViewController: UIPickerViewDelegate {
    
    // format hours, minutes, seconds in pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.formatPicker(row: row)
    }
    
    // selected values in picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.didSelect(row: row, component: component)
    }
}
