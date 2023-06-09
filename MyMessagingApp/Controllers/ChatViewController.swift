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

class ChatViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newChatButton: UIButton!
    
    let db = Firestore.firestore()
    
    var chats:[Chats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newChatButton.layer.cornerRadius=7
        navigationItem.hidesBackButton=true
        loadChats()
        
        tableView.dataSource=self
        tableView.delegate=self
        title=K.title
        tableView.register(UINib(nibName: K.chats.NibName, bundle: nil), forCellReuseIdentifier: K.chats.cellIdentifier)
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
    
    
    
    
    func loadChats(){
        chats=[]
        let dataRef=db.collection(K.Fstore.dataCollectionName)
        if let user=Auth.auth().currentUser?.email{
            dataRef.whereField("username", isEqualTo: user).getDocuments {(querySnapshot, error) in
                if let e=error{
                    print(e.localizedDescription)
                }else if let documents = querySnapshot?.documents,!documents.isEmpty{
                    let userDocID=documents[0].documentID
                    
                    let chatsRef=self.db.collection(K.Fstore.dataCollectionName).document(userDocID).collection(K.Fstore.ChatsCollectionName)
                    
                    chatsRef.addSnapshotListener{(querySnap, error) in
                        if let e=error{
                            print(e.localizedDescription)
                        }else if let docs = querySnap?.documents,!docs.isEmpty{
                            self.chats=[]
                            for doc in docs{
                                let data = doc.data()
                                
                                if let rcvr=data["receiver"] as? String {
                                    
                                    if rcvr != user{
                                        let chat=Chats(name: rcvr)
                                        self.chats.append(chat)
                                        DispatchQueue.main.async {
                                            self.tableView.reloadData()
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                        
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? ChatCell {
            performSegue(withIdentifier: K.chatsToMessageSegue, sender: cell)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == K.chatsToMessageSegue {
                if let destinationVC = segue.destination as? messageViewController {
                    let buttonName = sender as? ChatCell
                    destinationVC.receiver=buttonName?.profileName.text

                }
            }
        }
    

}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = chats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.chats.cellIdentifier, for: indexPath) as! ChatCell
        cell.profileName.text=msg.name
        return cell
    }
 
}

