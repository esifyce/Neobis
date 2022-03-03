//
//  AuthService.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import Foundation
import Firebase

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        
        guard let profileData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let fileName = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(profileData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion!(error)
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageURL =  url?.absoluteString else {return}
                
                
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    
                    let data = ["email": credentials.email,
                                "fullname":credentials.fullname,
                                "profileImageURL":imageURL,
                                "uid":uid,
                                "username":credentials.username] as [String:Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    
                }
                
            }
        }
    }
}
