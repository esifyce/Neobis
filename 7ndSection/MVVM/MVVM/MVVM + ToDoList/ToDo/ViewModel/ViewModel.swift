//
//  ViewModel.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import Foundation

class ViewModel: TableViewModelType {
    
    // Notification identifier
    static let addNotificationName = Notification.Name("myAddNotification")
    static let editNotificationName = Notification.Name("myEditNotification")
    
    // current selected
    private var selectedIndexPath: IndexPath?
    
    // Model instance
    var tasks = [Task]()
    
    var tempId: Int = 0
    
    // display count cells
    func numberOfRows() -> Int {
        return tasks.count
    }
    
    // remove cells by indexPath
    func removeCell(forIndexPath indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
    }
    
    // insert cells by indexPath
    func insertCell(_ newElement: Task,forIndexPath indexPath: IndexPath) {
        tasks.insert(newElement, at: indexPath.row)
    }
    
    // current cells by indexPath
    func currentCell(forIndexPath indexPath: IndexPath) -> Task {
        return tasks[indexPath.row]
    }
    
    // work with cell
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let task = tasks[indexPath.row]
        return TableViewCellViewModel(task: task)
    }
    
    // to get a cell by selected
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModelType(task: tasks[selectedIndexPath.row])
    }

    // choice row
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    // for get data from another vc and add cells in tableView
    func addNotification(notification: Notification) {

        if let dict = notification.object as? NSDictionary {
            for (titleReceive, descriptionReceive) in dict {
                guard let titleReceive = titleReceive as? String else { return }
                guard let descriptionReceive = descriptionReceive as? String else { return }

                if titleReceive != "" {
                tasks.insert(Task(title: titleReceive, description: descriptionReceive), at: 0)
                }
            }
        }
    }
    

    // for get data from another vc and edit cells in tableView
    func editNotification(notification: Notification) {

        if let dict = notification.object as? NSDictionary {
            for (titleReceive, descriptionReceive) in dict {
                guard let titleReceive = titleReceive as? String else { return }
                guard let descriptionReceive = descriptionReceive as? String else { return }
                tasks[tempId] = Task(title: titleReceive, description: descriptionReceive)
            }
        }
    }
    
    
    
}
