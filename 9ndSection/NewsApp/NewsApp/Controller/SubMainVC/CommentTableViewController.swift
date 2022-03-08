//
//  CommentTableViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import UIKit

private let commentIdentifier = "commentCell"

class CommentTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var id: String = "1"
    var comments = [PostsComment]()
    var parser = Parser()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        parseJSON()
    }
    
    // MARK: - Helper
    
    private func configureUI() {
        title = "Comments"
        
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: commentIdentifier)
    }
    
    private func parseJSON() {
        parser.getComments(id: id) {[weak self] data in
            self?.comments = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentIdentifier, for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].name
        return cell
    }
    
    
}
