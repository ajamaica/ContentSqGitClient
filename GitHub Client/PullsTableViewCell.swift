//
//  PullsTableViewCell.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit

class PullsTableViewCell: UITableViewCell {

    @IBOutlet var tableview_description: UITextView!
    @IBOutlet var label_user: UILabel!
    @IBOutlet var label_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
