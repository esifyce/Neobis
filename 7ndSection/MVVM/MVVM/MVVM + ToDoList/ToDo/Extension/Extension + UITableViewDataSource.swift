//
//  Extension + UITableViewDataSource.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 21.02.2022.
//

import UIKit

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource {
    // for receiving elemnts count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.numberOfRows() == 0 {
            textView.isHidden = false
            return viewModel?.numberOfRows() ?? 0
        } else {
            textView.isHidden = true
            return viewModel?.numberOfRows() ?? 0
        }
    }
    // for manimulation with row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.accessoryType = .detailDisclosureButton
        tableViewCell.selectionStyle = .none
        
        tableViewCell.viewModel = cellViewModel
        
        
        return tableViewCell
    }
}
