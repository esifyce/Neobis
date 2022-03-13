//
//  PostsImage.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation
import RealmSwift

class PostsImage: Object, Requestable {
    @objc dynamic var id: Int
    @objc dynamic var url: String?
    
    static var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos")!
        let request = URLRequest(url: url)
        return request
    }
}
