//
//  ChatViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 29/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newChatButton: UIButton!
    
    let db = Firestore.firestore()
    
    var chats:[Chats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newChatButton.layer.cornerRadius=7
        navigationItem.hidesBackButton=true
        
//        let dataRef=db.collection(K.Fstore.dataCollectionName)
//        if let user=Auth.auth().currentUser?.email{
//            dataRef.whereField("username", isEqualTo: user).getDocuments {(querySnapshot, error) in
//                if let e=error{
//                    print(e.localizedDescription)
//                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
//                    let document=documents[0]
//                    self.db.collection(K.Fstore.dataCollectionName).document(document.documentID).collection(K.Fstore.ChatsCollectionName)
//                }else{
//                    print("some other error")
//                }
//            }
//
//        }
        
//        tableView.dataSource=self
//
//        tableView.register(UINib(nibName: K.chats.NibName, bundle: nil), forCellReuseIdentifier: K.chats.cellIdentifier)
    }

    @IBAction func startNewChat(_ sender: UIButton) {

        
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError.localizedDescription)
        }
    }
    
    
    
    
//    func loadChats(){
//        db.collection(K.chats.chatsCollection)
//    }
    

    

}

//extension ChatViewController:UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chats.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let username=chats[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.chats.cellIdentifier, for: indexPath) as! ChatCell
//        cell.profileName.setTitle(username.name, for: .normal)
//
//        return cell
//    }
//
//
//}
