//
//  ChatCell.swift
//  ParseChat
//
//  Created by Siraj Zaneer on 12/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
