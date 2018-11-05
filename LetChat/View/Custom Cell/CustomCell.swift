//
//  CustomCell.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/5.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var mgsLabel: UILabel!
    @IBOutlet weak var fdName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
