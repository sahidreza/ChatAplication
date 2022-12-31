//
//  K.swift
//  Chat Application
//
//  Created by Sahid Reza on 30/12/22.
//

import Foundation

struct K {
    
    static let validaionMessage = "Please fill up all the details"
    static let messageReusableCell = "messageCell"
    static let nibMessageName = "ChatTableViewCell"
    static let perperC0lour = "rightViewColor"
    static let assColour = "leftViewColour"
    
    struct StoryBoardSegue{
        
        static let registerToChat = "regesterToChat"
        static let loginToChat = "LoginToChat"
        
    }
    
    struct FirebaseDetails {
        
        static let firebase_tableName = "user_Communication"
        static let firebase_userDisplayName = "userName"
        static let firebase_emilID = "emilID"
        static let firebase_messageBody = "messageBody"
        static let firbase_messageTime = "timePerSecond"
        
        
        
    }
    
    private init() {}
    
}
