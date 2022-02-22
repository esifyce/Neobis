//
//  Extension + UITextViewDelegate.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import UIKit

// MARK: - TextView delegate for add placeholder
extension AddTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewIs.textColor == .systemGray3 {
            textViewIs.text = ""
            textViewIs.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textViewIs.text == "" {
            textViewIs.text = "Описание"
            textViewIs.textColor = .systemGray3
        }
    }
}
