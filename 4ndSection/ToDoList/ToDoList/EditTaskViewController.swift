//
//  EditTaskViewController.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 26.01.2022.
//

import UIKit

class EditTaskViewController: AddTaskViewController {
    
    // MARK: - lifecycle vc
    override func viewDidLoad() {
        super.viewDidLoad()
        // override only rightbarbutton for change title and action
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(editButton))
    }
    // MARK: - @objc func
    @objc func editButton() {
        // new user input text
        let nameTextFieldSent = textFieldView.text
        let descriptionTextViewSent = textViewIs.text
        
        // set input values in dictionary in format [title: description]
        let dictionaryTextSent = [nameTextFieldSent: descriptionTextViewSent]
        // Pass data to use Notification Id VC and object
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myEditNotification"), object: dictionaryTextSent)
        
        // close vc
        dismiss(animated: true, completion: nil)
    }
}
