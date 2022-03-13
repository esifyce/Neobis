//
//  UsersViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 7/3/22.
//

import UIKit
import RealmSwift

private let userIdentifier = "userCell"

class UsersViewController: UITableViewController {
    
    // MARK: - Property
    private var parser = Parser()
    private var realm: Realm?
    private var users: Results<Users>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.realm = try Realm()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        // Do any additional setup after loading the view.
        configureUI()
        parseJSON()
        getData()
        
        users = realm?.objects(Users.self)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "All user"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: userIdentifier)
    }
    
    private func parseJSON() {
        parser.getUsers { [weak self] data in
            DispatchQueue.main.async {
                self?.getData(data)
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showError(_ error: Error?) {
        if let error = error {
            print("DEBUG: \(String(describing: error.localizedDescription))")
            return
        }
    }
    
    private func getData(_ data: [Users]? = nil) {
        
        guard let data = data else {
            return
        }
        
        try! realm?.write {
            realm?.delete(users)
        }
        
        realm?.beginWrite()
        realm?.add((data.compactMap { $0 }))
        
        try! realm?.commitWrite()
        
        tableView.reloadData()
    }
    
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: userIdentifier)
        let item = users?[indexPath.row]
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = item?.username
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UserInfoViewController()
        let item = users[indexPath.row]
        
        vc.userId.text = "id = \(String(describing: item.id))"
        vc.userName.text = "name = \(String(describing: item.name))"
        vc.userPhone.text = "phone = \(String(describing: item.phone))"
        vc.nickname.text = "username = \(String(describing: item.username))"
        vc.userWebsite.text = "website = \(String(describing: item.website))"
        vc.userCompany.text = "company = \(String(describing: item.company?.name ?? "None"))"
        vc.userEmail.text = "email = \(String(describing: item.email))"
        navigationController?.pushViewController(vc, animated: true)
    }
}
