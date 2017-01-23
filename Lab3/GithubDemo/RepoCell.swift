//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Jacob Smith on 1/22/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var repoDes: UILabel!
    @IBOutlet weak var forkCount: UILabel!
    @IBOutlet weak var forkImage: UIImageView!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
