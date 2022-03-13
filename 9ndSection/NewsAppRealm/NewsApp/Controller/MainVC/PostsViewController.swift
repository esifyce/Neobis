//
//  PostsViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 7/3/22.
//

import UIKit
import RealmSwift

class PostsViewController: UIViewController {
    
    // MARK: - Property
    
    var postImages = [PostsImage]()
    let parser = Parser()
    
    private var realm: Realm?
    private var items: Results<Posts>?
    private var postImg: Results<PostsImage>?
    
    // MARK: - View Property
    
    var tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView(frame: .zero)
        table.rowHeight = 180
        table.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.identifier)
        
        return table
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.realm = try Realm()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        configureUI()
        parseJSON()
        getData()
        
        items = realm?.objects(Posts.self)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "All post"
        view.backgroundColor = .white
        
        configureTableView()
        
    }
    
    private func getData(_ data: [Posts]? = nil) {
        
        guard let data = data else {
            return
        }
        if items != nil {
            try! realm?.write {
                realm?.delete(items!)
            }
        }
        
        realm?.beginWrite()
        realm?.add((data.compactMap { $0 }))
        
        try! realm?.commitWrite()
        
        tableView.reloadData()
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        
        tableView.frame = view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // stretch to tabbar
        let adjustForTabbarInsets = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: tabBarController?.tabBar.frame.height ?? 0,
                                                 right: 0)
        tableView.contentInset = adjustForTabbarInsets
        tableView.scrollIndicatorInsets = adjustForTabbarInsets
    }
    
    func parseJSON() {
        
        parser.getPosts { [weak self] data in
            DispatchQueue.main.sync {
                self?.getData(data)
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier,
                                                       for: indexPath) as? PostViewCell else {
            return UITableViewCell()
        }
        
        guard let item = items?[indexPath.row] else {
            return cell
        }
        DispatchQueue.main.async {
            cell.configure(title: item.title,
                           subtitle: item.desc)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = CommentTableViewController()
        controller.id = "\(indexPath.row + 1)"
        navigationController?.pushViewController(controller, animated: true)
    }
}
