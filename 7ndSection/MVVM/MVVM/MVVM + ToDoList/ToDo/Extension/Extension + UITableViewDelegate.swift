//
//  Extension + UITableViewDelegate.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import UIKit

extension HomeViewController: UITableViewDelegate {
    // for permission edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // for delete row in editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeCell(forIndexPath: indexPath)
            tableView.reloadData()
        }
    }
    // for setup move row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let itemToMove = viewModel?.currentCell(forIndexPath: sourceIndexPath) else { return }
        viewModel?.removeCell(forIndexPath: sourceIndexPath)
        viewModel?.insertCell(itemToMove, forIndexPath: sourceIndexPath)
    }
    
    // for permisions move row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // for select cell and display editingcontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRow(atIndexPath: indexPath)
        
        let vc = EditTaskViewController()
        vc.textFieldView.text = viewModel?.viewModelForSelectedRow()?.title
        vc.textViewIs.text = viewModel?.viewModelForSelectedRow()?.description
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .overCurrentContext
        
        present(navigationController, animated: true, completion: nil)
    }
}
