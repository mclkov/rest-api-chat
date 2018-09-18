//
//  MessageCell.swift
//  smack
//
//  Created by McL on 9/18/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(messageArray: Message)
    {
        messageBodyLabel.text = messageArray.message
        userNameLabel.text = messageArray.userName
        userImage.image = UIImage(named: messageArray.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: messageArray.userAvatarColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
