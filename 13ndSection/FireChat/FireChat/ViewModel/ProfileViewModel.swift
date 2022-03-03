//
//  ProfileViewModel.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import Foundation


enum ProfileViewModel:Int, CaseIterable {
   
    case accountInfo
    case settings
    
    var description:String {
        switch self {
        case .accountInfo:
            return "Account Info"
        case .settings:
            return "Settings"
        }
    }
    
    var iconImages: String {
        switch self {
        case .accountInfo:
            return "person.circle"
        case .settings:
            return "gear"
        }
    }
    
}
