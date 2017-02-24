//
//  MenuCellTableViewCell.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 24/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit

class MenuCellTableViewCell: UITableViewCell {

    @IBOutlet var img_menu: UIImageView!
    @IBOutlet var label_menu_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
