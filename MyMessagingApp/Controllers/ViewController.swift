//
//  ViewController.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 01/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var registerButtonLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonLabel.layer.cornerRadius=10
        registerButtonLabel.layer.cornerRadius=10
    }


}

