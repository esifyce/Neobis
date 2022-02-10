//
//  Extension + FinanceTableView.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FinanceTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinanceCustomTableViewCell.identifier,for: indexPath) as? FinanceCustomTableViewCell else { return UITableViewCell() }
        
        cell.textLabel?.text = finance[indexPath.row].title
        cell.imageView?.image = UIImage(systemName: finance[indexPath.row].image, withConfiguration: .none)
        cell.imageView?.tintColor = UIColor(named: finance[indexPath.row].color)
        
        cell.configure(price: "$\(finance[indexPath.row].price)", product: finance[indexPath.row].category)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemTeal
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(finance[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
