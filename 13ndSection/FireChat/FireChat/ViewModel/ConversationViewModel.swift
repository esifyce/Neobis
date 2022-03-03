//
//  ConversationViewModel.swift
//  FireChat
//
//  Created by Sabir Myrzaev on 27/2/22.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
    
    var profileImageUrl:URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp:String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: date)
    }
}
