//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit

struct LoginViewModel:AuthenticationProtocol {
    var email:String?
    var password:String?
    
    var formIsValid:Bool {
        // Only returns true if both email and password are not empty
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
