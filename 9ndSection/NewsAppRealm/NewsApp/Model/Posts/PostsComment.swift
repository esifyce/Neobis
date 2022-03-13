//
//  PostsComment.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import Foundation
import RealmSwift

class PostsComment: Object, Codable {
    @objc dynamic var postId: Int
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var email: String
    @objc dynamic var body: String
}
