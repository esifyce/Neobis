//
//  Users.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation
import RealmSwift

class Users: Object, Requestable {
    @objc dynamic var  id: Int = 0
    @objc dynamic var  username: String = ""
    @objc dynamic var  name: String = ""
    @objc dynamic var  email: String = ""
    @objc dynamic var  phone: String = ""
    @objc dynamic var  website: String = ""
    @objc dynamic var  company: UserCompany?
    
    static var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let request = URLRequest(url: url)
        return request
    }
}

class UserCompany: Object, Codable {
    @objc dynamic var name: String = ""
}
