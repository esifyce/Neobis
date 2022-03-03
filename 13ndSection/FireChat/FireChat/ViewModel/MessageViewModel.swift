//
//  MessageViewModel.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import UIKit

struct MessageViewModel {
    
    private let message:Message
    
    init(message: Message) {
        self.message = message
    }
    
    var messageBackgroundColor:UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 0.8431372549, green: 0.7176470588, blue: 0.4509803922, alpha: 1)
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    var rightAnchorActive:Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive:Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage:Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl:URL? {
        guard let user = message.user else {return nil}
        
        return URL(string: user.profileImageUrl)
    }
    
}
