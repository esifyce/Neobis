//
//  UsersViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 7/3/22.
//

import UIKit

private let userIdentifier = "userCell"

class UsersViewController: UITableViewController {
    
    // MARK: - Property
    var users = [Users]()
    var parser = Parser()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        parseJSON()
    }
    
    private func configureUI() {
        title = "All user"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: userIdentifier)
    }
    // MARK: - Helpers
    
    func parseJSON() {
        parser.getUsers { [weak self] data in
            self?.users = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func showError(_ error: Error?) {
        if let error = error {
            print("DEBUG: \(String(describing: error.localizedDescription))")
            return
        }
    }
    
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: userIdentifier)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].username
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserInfoViewController()
        let user = users[indexPath.row]
        vc.userId.text = "id = \(user.id)"
        vc.userName.text = "name = \(user.name)"
        vc.userPhone.text = "phone = \(user.phone)"
        vc.nickname.text = "username = \(user.username)"
        vc.userWebsite.text = "website = \(user.website)"
        vc.userCompany.text = "company = \(user.company.name)"
        vc.userEmail.text = "email = \(user.email)"
        navigationController?.pushViewController(vc, animated: true)
    }
}
