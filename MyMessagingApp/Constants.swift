//
//  Constants.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 10/04/23.
//

import Foundation
struct K{
    static let newChatToChatSegue="newChatSegue"
    static let chatsToMessageSegue="chatMessageSegue"
    static let users = "Users"
    static let usernames="usernames"
    static let registerSegue="registerToChatSegue"
    static let loginSegue="loginToChatSegue"
    static let msgCellIdentifier="messageCell"
    static let NibName="MessageCell" //name of the message cell swift file
    static let title = "Appy Aapy"
    struct Fstore{
        static let dataCollectionName = "data"
        static let ChatsCollectionName = "Chats"
        static let messagesCollectionName = "messages"
        static let senderFieldName = "sender"
        static let msgFieldName = "message_sent"
        static let dateFieldName = "date"
    }
    struct chats{
        static let NibName="ChatCell"
        static let cellIdentifier="chatCell"
        static let chatsCollection = "chats"
    }
}
