//
//  Constants.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 10/04/23.
//

import Foundation
struct K{
    static let registerSegue="registerToChatSegue"
    static let loginSegue="loginToChatSegue"
    static let cellIdentifier="messageCell"
    static let NibName="MessageCell" //name of the message cell swift file
    
    struct Fstore{
        static let collectionName = "messages"
        static let senderFieldName = "sender"
        static let msgFieldName = "message_sent"
        static let dateFieldName = "date"
    }
}
