//
//  PostsViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 7/3/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: - Property
    
    var posts = [Posts]()
    var postImages = [PostsImage]()
    let parser = Parser()
    
    var postId = "1"
    
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
        
        configureUI()
        parseJSON()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "All post"
        view.backgroundColor = .white
        
        configureTableView()
        
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
            self?.posts = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        parser.getImagePosts { [weak self] data in
            self?.postImages = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as? PostViewCell else { return UITableViewCell() }
        postId = "\(indexPath.row)"
        guard let url = URL(string: postImages.randomElement()?.url ?? "") else { return UITableViewCell() }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async { [weak self] in
                cell.configure(title: self?.posts[indexPath.row].title ?? "",
                               subtitle: self?.posts[indexPath.row].description ?? "",
                               image: data)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CommentTableViewController()
        controller.id = "\(indexPath.row + 1)"
        navigationController?.pushViewController(controller, animated: true)
    }
}
