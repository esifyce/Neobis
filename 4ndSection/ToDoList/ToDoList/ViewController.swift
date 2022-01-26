//
//  ViewController.swift
//  ToDoList
//
//  Created by Sabir Myrzaev on 24.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Notification identifier
    static let addNotificationName = Notification.Name("myAddNotification")
    static let editNotificationName = Notification.Name("myEditNotification")
      
    // MARK: - Properties
    let cellReuseIdentifier = "cell"
    private var tasks = [Task]()
    private var isActive = false
    var tempId: Int = 0
    
    // MARK: - View and Layout properties
    private lazy var tableViewIs: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.bottom.top.left.right.equalToSuperview()
        }
        return tableView
    }()
    
    private lazy var editButtonView: UIButton = {
        let editButton = UIButton(type: .system)
        editButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        editButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        editButton.tintColor = .systemBlue
        
        view.addSubview(editButton)
        editButton.addTarget(self, action: #selector(editTask), for: .touchUpInside)
        
        editButton.snp.makeConstraints {
            $0.bottom.equalTo(plusButtonView.snp.bottom).inset(70)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        return editButton
    }()
    
    private lazy var plusButtonView: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        plusButton.tintColor = .systemGreen
        
        view.addSubview(plusButton)
        plusButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        plusButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        return plusButton
    }()
    
    private lazy var textView: UILabel = {
        let text = UILabel()
        view.addSubview(text)
        text.text = "Создайте новую задачу нажав на кнопку плюс"
        text.numberOfLines = 0
        text.textAlignment = .center
        text.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        return text
    }()
    
    // merge all UIviews elements in array for display on screen
    private lazy var listLayoutViews = [tableViewIs, editButtonView, plusButtonView,textView]
    
    // MARK: - lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // pass to every elements for show on screen
        let _ = listLayoutViews.compactMap { $0 }
        
        textView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // recieve data by add observer
        NotificationCenter.default.addObserver(self, selector: #selector(onAddNotification(notification:)),
                                               name: ViewController.addNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onEditNotification(notification:)),
                                               name: ViewController.editNotificationName, object: nil)
    }
    
    // add permission editing tableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableViewIs.setEditing(editing, animated: animated)
    }
    
    // for get data from another vc and add cells in tableView
    @objc func onAddNotification(notification: Notification) {
        
        if let dict = notification.object as? NSDictionary {
            for (titleReceive, descriptionReceive) in dict {
                guard let titleReceive = titleReceive as? String else { return }
                guard let descriptionReceive = descriptionReceive as? String else { return }
                
                if titleReceive != "" {
                let indexPath = IndexPath(row: 0, section: 0)
                tasks.insert(Task(title: titleReceive, description: descriptionReceive), at: 0)
                tableViewIs.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    // for get data from another vc and edit cells in tableView
    @objc func onEditNotification(notification: Notification) {
        
        if let dict = notification.object as? NSDictionary {
            for (titleReceive, descriptionReceive) in dict {
                guard let titleReceive = titleReceive as? String else { return }
                guard let descriptionReceive = descriptionReceive as? String else { return }
                tasks[tempId] = Task(title: titleReceive, description: descriptionReceive)
            }
            tableViewIs.reloadData()
        }
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
    
    // Implementation checkark task
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        
        if imgView.image != UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) {
            imgView.image = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            imgView.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // for receiving elemnts count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count == 0 {
            textView.isHidden = false
            return tasks.count
        } else {
            textView.isHidden = true
            return tasks.count
        }
    }
    // for manimulation with row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailDisclosureButton
        cell.selectionStyle = .none
        
        cell.imageView?.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.imageView?.addGestureRecognizer(tapGesture)
        cell.imageView?.isUserInteractionEnabled = true
        
        
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text = tasks[indexPath.row].description
        
        return cell
    }
    // for permission edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // for delete row in editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    // for setup move row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    // for permisions move row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // for select cell and display editingcontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempId = indexPath.row
        
        let vc = EditTaskViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .overCurrentContext
        
        present(navigationController, animated: true, completion: nil)
    }
 
}
