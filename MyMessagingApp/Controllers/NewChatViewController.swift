//
//  NewChatViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 29/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



class NewChatViewController: UIViewController,UITableViewDelegate{


    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var users:[Chats]=[]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        
                
        
        title="Start a new Chat"
        tableView.dataSource=self
        tableView.delegate=self
        tableView.register(UINib(nibName: K.chats.NibName, bundle: nil), forCellReuseIdentifier: K.chats.cellIdentifier)
        
        
    }
    func loadUsers(){
        users=[]
        db.collection(K.users).addSnapshotListener { QuerySnapshot, error in
            if let e = error{
                print(e)
            }else{
                if let snapDocs=QuerySnapshot?.documents{
                    for doc in snapDocs{
                        let data = doc.data()
                        if let username=data[K.usernames] as? String{
                            let usr=Chats(name: username)
                            self.users.append(usr)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
//                                let indexPath=IndexPath(row: self.users.count-1, section: 0)
//                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      print("yes chick")
//        view profile pic code will be here
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.newChatToChatSegue {
                if let destinationVC = segue.destination as? messageViewController {
                    let buttonName = sender as? ChatCell
                        destinationVC.receiver=buttonName?.profileName.titleLabel?.text!
                    
                }
            }
        }


}
extension NewChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let username=users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.chats.cellIdentifier, for: indexPath) as! ChatCell
        cell.profileName.setTitle(username.name, for: .normal)
        cell.viewController=self
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

//
}

