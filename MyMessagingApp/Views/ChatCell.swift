//
//  ChatCellTableViewCell.swift
//  MyMessagingApp
//
//  Created by AKSHAY KUMAR on 29/04/23.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePhoto.layer.cornerRadius=25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
