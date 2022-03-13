//
//  CommentTableViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import UIKit
import RealmSwift

private let commentIdentifier = "commentCell"

class CommentTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var id: String = "1"
    var parser = Parser()
    private var realm: Realm?
    private var comment: Results<PostsComment>?
    
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

        comment = realm?.objects(PostsComment.self)
    }
    
    // MARK: - Helper
    
    private func getData(_ data: [PostsComment]? = nil) {
        
        guard let data = data else {
            return
        }

        if comment != nil {
            try! realm?.write {
                realm?.delete(comment!)
            }
        }
        
        realm?.beginWrite()
        realm?.add((data.compactMap { $0 }))
        
        try! realm?.commitWrite()
        
        tableView.reloadData()
    }
    
    private func configureUI() {
        title = "Comments"
        
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: commentIdentifier)
    }
    
    private func parseJSON() {
        parser.getComments(id: id) {[weak self] data in
            DispatchQueue.main.async {
                self?.getData(data)
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentIdentifier, for: indexPath)
        cell.textLabel?.text = comment?[indexPath.row].name
        return cell
    }
    
    
}
