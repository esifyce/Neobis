//
//  Posts.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation

protocol Requestable: Decodable {
    static var urlRequest: URLRequest { get }
}

struct Posts: Requestable {
    let userId: Int
    let postId: Int
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case title, userId
        case postId = "id"
        case description = "body"
    }
    
    static var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let request = URLRequest(url: url)
        return request
    }
}
