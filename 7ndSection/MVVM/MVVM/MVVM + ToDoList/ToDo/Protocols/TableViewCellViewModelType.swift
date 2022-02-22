//
//  TableViewCellViewModelType.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import Foundation

protocol TableViewCellViewModelType {
    var title: String { get }
    var description: String { get }
    var completed: Bool { get }
}
