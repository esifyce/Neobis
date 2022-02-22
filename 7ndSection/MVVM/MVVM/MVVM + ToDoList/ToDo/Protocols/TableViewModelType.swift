//
//  TableViewModelType.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import Foundation

 protocol TableViewModelType: AnyObject {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func addNotification(notification: Notification)
    func editNotification(notification: Notification)
    
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    
    func removeCell(forIndexPath indexPath: IndexPath)
    func insertCell(_ newElement: Task,forIndexPath indexPath: IndexPath)
    func currentCell(forIndexPath indexPath: IndexPath) -> Task
}
