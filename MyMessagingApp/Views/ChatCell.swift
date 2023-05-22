//
//  ChatCellTableViewCell.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 29/04/23.
//

import UIKit

class ChatCell: UITableViewCell{

    @IBOutlet weak var profilePhoto: UIImageView!
 
    @IBOutlet weak var profileName: UILabel!

    weak var viewController: UIViewController?
    
//    @IBAction func profileSelected(_ sender: UIButton) {
//        if let viewController = viewController {
//            viewController.performSegue(withIdentifier: K.newChatToChatSegue, sender: self)
//                }
//
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePhoto.layer.cornerRadius=25
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    

    
}
