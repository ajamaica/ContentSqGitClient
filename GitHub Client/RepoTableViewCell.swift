//
//  RepoTableViewCell.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var owner: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
