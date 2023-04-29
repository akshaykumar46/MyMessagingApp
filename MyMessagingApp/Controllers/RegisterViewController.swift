//
//  RegisterViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 09/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerButtonLabel: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        registerButtonLabel.layer.cornerRadius=10
    }

    @IBAction func RegisterButton(_ sender: UIButton) {
        if let email=usernameField.text,let password=passwordField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e=error{
                    print(e.localizedDescription)
//                    print("error in registering")
                }else{
                    self.db.collection(K.users).addDocument(data: [K.usernames:email])
                    self.db.collection(K.users)
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
}
