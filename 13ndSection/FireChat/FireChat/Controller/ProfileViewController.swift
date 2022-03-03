//
//  ProfileViewController.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

protocol ProfileViewControllerDelegate:AnyObject {
    func handleLogout()
}

class ProfileViewController: UITableViewController {
    
    private var user:User? {
        didSet {
            headerView.user = user
        }
    }
    
    weak var delegate: ProfileViewControllerDelegate?
    
    // MARK: - Properties
    
    private lazy var headerView:ProfileHeader = {
        let header = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
        header.delegate = self
        
       return header
    }()
    
    private lazy var footerView:ProfileFooter = {
        let footer = ProfileFooter(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
        footer.delegate = self
        
        return footer
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    //MARK: - Selectors
    
    
    
    //MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        showLoader(true)
        
        Service.fetchUser(withUid: uid) { user in
            
            self.showLoader(false)
            self.user = user
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = footerView
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.rowHeight = 64
        tableView.backgroundColor = UIColor(named: "background")
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        
        cell.backgroundColor = .white
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else {return}
        
        print("DEBUG: Handle Action for \(viewModel.description)")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}


//MARK: - ProfileHeaderDelegate

extension ProfileViewController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - ProfileFooterDelegate

extension ProfileViewController: ProfileFooterDelegate {
    func handleLogout() {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
