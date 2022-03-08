//
//  Users.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation

struct Users: Requestable {
    let id: Int
    let username: String
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: UserCompany
    
    static var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let request = URLRequest(url: url)
        return request
    }
}

struct UserCompany: Decodable {
    let name: String
}
