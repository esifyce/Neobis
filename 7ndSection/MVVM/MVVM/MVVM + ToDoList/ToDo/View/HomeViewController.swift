//
//  ViewController.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 24.01.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var isActive = false
    
    var viewModel: TableViewModelType?
    
    
    // MARK: - View and Layout properties
    private lazy var tableViewIs: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var editButtonView: UIButton = {
        let editButton = UIButton(type: .system)
        editButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        editButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        editButton.tintColor = .systemBlue
        
        editButton.addTarget(self, action: #selector(editTask), for: .touchUpInside)
        
        return editButton
    }()
    
    private lazy var plusButtonView: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        plusButton.tintColor = .systemGreen
        
        plusButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        return plusButton
    }()
    
    lazy var textView: UILabel = {
        let text = UILabel()
        text.text = "Создайте новую задачу нажав на кнопку плюс"
        text.numberOfLines = 0
        text.textAlignment = .center
        
        return text
    }()
    
    // MARK: - lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // pass to every elements for show on screen
        setSubviews()
        setConstraints()
        
        textView.isHidden = true
        
        viewModel = ViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // recieve data by add observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onAddNotification(notification:)),
                                               name: ViewModel.addNotificationName, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onEditNotification(notification:)),
                                               name: ViewModel.editNotificationName, object: nil)
    }
    
    // add permission editing tableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableViewIs.setEditing(editing, animated: animated)
    }
    
    // add in view
    private func setSubviews() {
        view.addSubview(tableViewIs)
        view.addSubview(editButtonView)
        view.addSubview(plusButtonView)
        view.addSubview(textView)
    }
    
    // assign contraints in subviews
    private func setConstraints() {
        
        tableViewIs.snp.makeConstraints {
            $0.bottom.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        editButtonView.snp.makeConstraints {
            $0.bottom.equalTo(plusButtonView.snp.bottom).inset(70)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        plusButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    // for get data from another vc and add cells in tableView
    @objc func onAddNotification(notification: Notification) {
        viewModel?.addNotification(notification: notification)
        let indexPath = IndexPath(row: 0, section: 0)
        tableViewIs.insertRows(at: [indexPath], with: .automatic)
    }
    
    // for get data from another vc and edit cells in tableView
    @objc func onEditNotification(notification: Notification) {
        viewModel?.editNotification(notification: notification)
        tableViewIs.reloadData()
    }
    
    // MARK: - @objc functions
    // New viewcontroller transition for add cell
    @objc func addTask() {
        let vc = AddTaskViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .overCurrentContext
        present(navigationController, animated: true, completion: nil)
    }
    
    // create function editButtons
    @objc func editTask() {
        isActive.toggle()
        if isActive {
            plusButtonView.isHidden = true
            editButtonView.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        } else {
            plusButtonView.isHidden = false
            editButtonView.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        }
        
        self.isEditing = !self.isEditing
    }
}
