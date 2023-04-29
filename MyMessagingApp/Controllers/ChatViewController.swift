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
    
//    let db = Firestore.firestore()
    
    var chats:[Chats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newChatButton.layer.cornerRadius=7
        navigationItem.hidesBackButton=true
        
//        tableView.dataSource=self
//
//        tableView.register(UINib(nibName: K.chats.NibName, bundle: nil), forCellReuseIdentifier: K.chats.cellIdentifier)
    }

    @IBAction func startNewChat(_ sender: UIButton) {

        
        
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
