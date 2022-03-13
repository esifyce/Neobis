//
//  Parser.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation

class Parser {

    func getPosts(completion: @escaping ([Posts]) -> ()) {
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: Posts.urlRequest) { [weak self] data, response, error in
                self?.showError(error)
                guard let data = data else { return }
                
                do {
                    let post = try JSONDecoder().decode([Posts].self, from: data)
                    completion(post)
                } catch {
                    self?.showError(error)
                }
            }.resume()
        }
    }
    
    func getUsers(completion: @escaping ([Users]) -> ()) {
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: Users.urlRequest) { [weak self] data, response, error in
                self?.showError(error)
                guard let data = data else { return }
                
                do {
                    let user = try JSONDecoder().decode([Users].self, from: data)
                    completion(user)
                } catch {
                    self?.showError(error)
                }
            }.resume()
        }
    }
    
    func getComments(id: String, completion: @escaping ([PostsComment]) -> ()) {
        DispatchQueue.main.async {
            guard let urlPost = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)/comments") else { return }
            
            URLSession.shared.dataTask(with: urlPost) { [weak self] data, response, error in
                self?.showError(error)
                guard let data = data else { return }
                
                do {
                    let comments = try JSONDecoder().decode([PostsComment].self, from: data)
                    completion(comments)
                } catch {
                    self?.showError(error)
                }
            }.resume()
        }
    }
    
    func showError(_ error: Error?) {
        if let error = error {
            print("DEBUG: \(String(describing: error.localizedDescription))")
            return
        }
    }
}
