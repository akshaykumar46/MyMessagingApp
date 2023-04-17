//
//  LoginViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 09/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginButton(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e=error{
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
   

}
