//
//  MessageCell.swift
//  Chat
//
//  Created by Alla Golovinova on 05.10.2021.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var MessageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightViewWithImage: UIView!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftViewWithImage: UIView!
    @IBOutlet weak var leftNameLabel: UILabel!
    
    @IBOutlet weak var rightSpaceView: UIView!
    @IBOutlet weak var leftSpaceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MessageBubble.layer.cornerRadius = MessageBubble.frame.height / 3
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
