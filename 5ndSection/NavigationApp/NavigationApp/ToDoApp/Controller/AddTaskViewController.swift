//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 25.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: - View and Layout properties
    lazy var textFieldView: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "Название"
        textField.backgroundColor = UIColor.white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 5
        textField.layer.shadowRadius = 2
        textField.becomeFirstResponder()
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.right.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
        }
        
        return textField
    }()
    
     lazy var textViewIs: UITextView = {
        let textView = UITextView()
        textView.text = "Описание"
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .systemGray3
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 5
        textView.layer.shadowRadius = 2
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(gray: 0.6, alpha: 1)
        textView.resignFirstResponder()
        
        textView.delegate = self
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.top.equalTo(textFieldView.snp.top).inset(70)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        return textView
    }()
    
    // merge all UIviews elements in array for display on screen
    private lazy var listLayoutViews = [textFieldView, textViewIs]

    // MARK: - lifecycle vc
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        let _ = listLayoutViews.compactMap { $0 }
    }
    
    // MARK: - @objc func
    // save text from fields and pass through NotificationCenter
    @objc private func saveButton() {
        let nameTextFieldSent = textFieldView.text
        let descriptionTextViewSent = textViewIs.text
        
        let dictionaryTextSent = [nameTextFieldSent: descriptionTextViewSent]
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myAddNotification"), object: dictionaryTextSent)
        
         dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

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

