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
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var messageTextField: UITextView!
    
    let db = Firestore.firestore()
    
    var mesaages:[Message]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        messageTextField.layer.cornerRadius=20
        tableView.dataSource=self
        loadMessages()
        title="MyMessageApp"
        navigationItem.hidesBackButton=true
        tableView.register(UINib(nibName: K.NibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    func loadMessages(){
        
        db.collection(K.Fstore.collectionName).order(by: K.Fstore.dateFieldName).addSnapshotListener{ QuerySnapshot, error in
            self.mesaages=[]
            if let e = error {
                print(e)
            }else{
                if let snapDocs=QuerySnapshot?.documents{
                    for doc in snapDocs{
                        let data = doc.data()
                        if let sender=data[K.Fstore.senderFieldName] as? String , let msg=data[K.Fstore.msgFieldName] as? String{
                            let newMsg=Message(sender: sender, body: msg )
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
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        if let msg=messageTextField.text, let sender=Auth.auth().currentUser?.email {
            if msg.count>0{
            self.messageTextField.text=nil
            db.collection(K.Fstore.collectionName).addDocument(data: [K.Fstore.senderFieldName:sender,K.Fstore.msgFieldName:msg,K.Fstore.dateFieldName:Date().timeIntervalSince1970]){
                (error) in
                if let e=error{
                    print("Error in saving message")
                    print(e)
                }else{
                    print("message saved")
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
        cell.label.text=msg.body
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

