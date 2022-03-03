//
//  ConversationsViewController.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsViewController:UIViewController {
   
    //MARK: - Properties
    
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    
    private var conversationsDictionary = [String:Conversation]()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = UIColor(named: "primary")
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    }
    
    //MARK: - Selectors
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func showProfile() {
        let controller = ProfileViewController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - API
    
    func fetchConversations() {
        showLoader(true)
        
        Service.fetchConversations { conversations in
            conversations.forEach { conversation in
                let message = conversation.message
                self.conversationsDictionary[message.chatPartnerId] = conversation
            }
            self.showLoader(false)
            self.conversations = Array(self.conversationsDictionary.values).sorted{ $0.message.timestamp.dateValue() > $1.message.timestamp.dateValue() }
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    //MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginViewController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
        
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(named: "background")
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func showChatController(forUser user: User) {
        let controller = ChatViewController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ConversationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
}

extension ConversationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        
        cell.backgroundColor = .clear
        
        return cell
    }
}
    
    //MARK: - NewMessageControllerDelegate

extension ConversationsViewController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToChatWith user: User) {
        dismiss(animated: true, completion: nil)
        
       showChatController(forUser: user)
    }
}

extension ConversationsViewController: ProfileViewControllerDelegate {
    func handleLogout() {
        logOut()
    }
}

//MARK: - AuthenticationDelegate

extension ConversationsViewController: AuthenticationDelegate {
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchConversations()
    }
}
