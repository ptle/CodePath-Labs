//
//  messageTableViewCell.swift
//  ParseChat
//
//  Created by Peter Le on 2/7/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {
    @IBOutlet weak var message: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
