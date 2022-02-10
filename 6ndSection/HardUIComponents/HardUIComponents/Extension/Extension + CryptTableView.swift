//
//  Extension + CryptTableView.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CryptoTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        crypts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptCustomTableViewCell.identifier,for: indexPath) as? CryptCustomTableViewCell else { return UITableViewCell() }
        
        cell.configure(price: "$\(crypts[indexPath.row].priceOnDollar)",
                       product: crypts[indexPath.row].priceOnCrypt,
                       image: crypts[indexPath.row].image,
                       title: crypts[indexPath.row].name,
                       subtitle: "\(crypts[indexPath.row].percent)%")
        
        cell.backgroundColor = UIColor(named: "PrimaryBackground")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemTeal
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(crypts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


