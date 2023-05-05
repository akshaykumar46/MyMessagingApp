//
//  messageViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 10/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class messageViewController: UIViewController {
    
    var receiver:String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextView!
    
    let db = Firestore.firestore()
    
    
    struct Conversation {
        let id: String
        let participants: [String]
    }
    
    struct userDetails{
        let userDataId:String
        let receiverChatId:String
        let msgDocid:String
    }

    var mesaages:[Message]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

            self.setupConversation() { userDetails, error in
                if let error = error {
                    print("Error creating conversation: \(error.localizedDescription)")
                } else if let userDetail = userDetails {
                    print("Conversation created successfully!")
   
                }
            }
        self.setupConversationForReceiver(){ userDetails, error in
            if let error = error {
                print("Error creating conversation: \(error.localizedDescription)")
            } else if let userDetail = userDetails {
                print("Conversation created successfully!")

            }
        }
        messageTextField.frame=CGRect(x: messageTextField.frame.origin.x, y: messageTextField.frame.origin.y, width: messageTextField.frame.size.width, height: 100)
        messageTextField.layer.cornerRadius=10

        tableView.dataSource=self
        loadMessages()
        title=receiver!
        
//        navigationItem.hidesBackButton=true
        tableView.register(UINib(nibName: K.NibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    
    
    func setupConversation(completion: @escaping (userDetails?, Error?) -> Void){
       
        let dataRef=db.collection(K.Fstore.dataCollectionName)
        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: user).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                    completion(nil, error)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                     
                    let userDataRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                        userDataRef.whereField("receiver", isEqualTo: self.receiver!).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let documents = querySnapshot?.documents, !documents.isEmpty {
    //                        conversation already exist
                            let chatID=documents[0].documentID
                            
                            let user=userDetails(userDataId: userDocID, receiverChatId: chatID,msgDocid: "")
                            completion(user,nil)
                            
                            
                        }else{
//                            create new conversation
                            let newChatRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName).document()
                            newChatRef.setData(["receiver":self.receiver!]){
                                error in
                                if let error = error {
                                    completion(nil, error)
                                } else {
                                    // Retrieve the conversation ID
                                    let chatId = newChatRef.documentID
                                    let user=userDetails(userDataId: userDocID, receiverChatId: chatId,msgDocid: "")
                                    completion(user, nil)
                                }
                            }
                                
                        }
                    }
                }else{
                    print("something went wrong while trying to access the chat.")
                    completion(nil,nil)
                }
            }

        }
    }
    
    func setupConversationForReceiver(completion: @escaping (userDetails?, Error?) -> Void){
       
        let dataRef=db.collection(K.Fstore.dataCollectionName)
        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: receiver!).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                    completion(nil, error)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                     
                    let userDataRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                        userDataRef.whereField("receiver", isEqualTo: user).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let documents = querySnapshot?.documents, !documents.isEmpty {
    //                        conversation already exist
                            let chatID=documents[0].documentID
                            
                            let user=userDetails(userDataId: userDocID, receiverChatId: chatID,msgDocid: "")
                            completion(user,nil)
                            
                            
                        }else{
//                            create new conversation
                            let newChatRef=self.db.collection(K.Fstore.dataCollectionName)
                                .document(userDocID).collection(K.Fstore.ChatsCollectionName).document()
                            newChatRef.setData(["receiver":user]){
                                error in
                                if let error = error {
                                    completion(nil, error)
                                } else {
                                    // Retrieve the conversation ID
                                    let chatId = newChatRef.documentID
                                    let user=userDetails(userDataId: userDocID, receiverChatId: chatId,msgDocid: "")
                                    completion(user, nil)
                                }
                            }
                                
                        }
                    }
                }else{
                    print("something went wrong while trying to access the chat.")
                    completion(nil,nil)
                }
            }

        }
    }
    
    func createChat(completion: @escaping (userDetails?, Error?) -> Void) {
        let dataRef = db.collection(K.Fstore.dataCollectionName)

        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: user).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                    completion(nil, error)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                     
                    let userDataRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                        userDataRef.whereField("receiver", isEqualTo: self.receiver!).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let documents = querySnapshot?.documents, !documents.isEmpty {
    //                        conversation already exist
                            let chatID=documents[0].documentID
                            let details=userDetails(userDataId: userDocID, receiverChatId: chatID, msgDocid: "")
                            completion(details,nil)
                        }else{
                           print("something went wrong")
                            completion(nil,nil)
                        }
                    }
                }else{
                    print("something went wrong while trying to access the chat.")
                    completion(nil,nil)
                }
            }

        }
    }

    func createChatForReceiver(completion: @escaping (userDetails?, Error?) -> Void) {
        let dataRef = db.collection(K.Fstore.dataCollectionName)

        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: receiver!).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                    completion(nil, error)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                     
                    let userDataRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                        userDataRef.whereField("receiver", isEqualTo: user).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let documents = querySnapshot?.documents, !documents.isEmpty {
    //                        conversation already exist
                            let chatID=documents[0].documentID
                            let details=userDetails(userDataId: userDocID, receiverChatId: chatID, msgDocid: "")
                            completion(details,nil)
                        }else{
                           print("something went wrong")
                            completion(nil,nil)
                        }
                    }
                }else{
                    print("something went wrong while trying to access the chat.")
                    completion(nil,nil)
                }
            }

        }
    }


    // Add a new message to a conversation in Firestore
    func addMessage(userDetails: userDetails, sender: String, content: String, timestamp: TimeInterval, completion: @escaping (Message?, Error?) -> Void) {

        let msgData: [String: Any] = [
            "sender": sender,
            "content": content,
            "timestamp": timestamp
        ]
        let msgRef=db.collection(K.Fstore.dataCollectionName)
            .document(userDetails.userDataId)
            .collection(K.Fstore.ChatsCollectionName)
            .document(userDetails.receiverChatId)

        msgRef.collection(K.Fstore.messagesCollectionName)
            .addDocument(data: msgData){ error in
            if let error = error {
                print("Error in saving msg: \(error.localizedDescription)")
                completion(nil, error)
            } else {
                print("Msg saved successfully")
                let message = Message(sender: sender, content: content, timestamp: timestamp)
                completion(message, nil)
            }
        }
  
        }
    

 
    func loadMessages(){
        print("loading messages")
        let dataRef = db.collection(K.Fstore.dataCollectionName)
        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: user).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                     
                    let userDataRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                    userDataRef.whereField("receiver", isEqualTo: self.receiver!).getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let documents = querySnapshot?.documents,!documents.isEmpty {
                            let chatID=documents[0].documentID
                            
                            userDataRef.document(chatID).collection(K.Fstore.messagesCollectionName).order(by: "timestamp").addSnapshotListener{ QuerySnapshot, error in
                                self.mesaages=[]
                                if let e = error {
                                    print(e)
                                }else{
                                    if let snapDocs=QuerySnapshot?.documents{
                                        for doc in snapDocs{
                                            let data = doc.data()
                                            if let sender=data["sender"] as? String , let msg=data["content"] as? String, let timestamp=data["timestamp"]{
                                                let newMsg=Message(sender: sender, content: msg, timestamp: 12.3)
                                                self.mesaages.append(newMsg)

                                                DispatchQueue.main.async {
                                                    self.tableView.reloadData()
                                                    let indexPath=IndexPath(row: self.mesaages.count-1, section: 0)
                                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                                }
                                            }
                                            else{
                                                print("problem here!!")
                                            }
                                        }
                                    }
                                }
                            }
                        }else{
                           print("empty_array")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        if let msg=messageTextField.text, let sender=Auth.auth().currentUser?.email {
            if msg.count>0{
                self.messageTextField.text=nil
                
                createChat() { userDetails, error in
                    if let error = error {
                        print("Error creating conversation: \(error.localizedDescription)")
                    } else if let userDetails = userDetails {
                        //                            print("msgDoc created successfully! msgDoc ID: \(msgDocDetails.id)")
                        
                        self.addMessage(userDetails: userDetails, sender: sender, content: msg, timestamp: Date().timeIntervalSince1970) { message, error in
                            if let error = error {
                                print("Error adding message: \(error.localizedDescription)")
                            } else if (message != nil) {
                                print("Message added successfully! ")

                            }
                        }
                    }
                }
                createChatForReceiver() { userDetails, error in
                    if let error = error {
                        print("Error creating conversation: \(error.localizedDescription)")
                    } else if let userDetails = userDetails {
                        //                            print("msgDoc created successfully! msgDoc ID: \(msgDocDetails.id)")
                        
                        self.addMessage(userDetails: userDetails, sender: sender, content: msg, timestamp: Date().timeIntervalSince1970) { message, error in
                            if let error = error {
                                print("Error adding message: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
                else{
                    print("empty message!")
                }
            }
            
        }
    
     
    
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
extension messageViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesaages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = mesaages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text=msg.content
        if msg.sender==Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden=true
            cell.rightImageView.isHidden=false
        }else{
            cell.rightImageView.isHidden=true
            cell.leftImageView.isHidden=false
        }
       
        return cell
    }
 
}

