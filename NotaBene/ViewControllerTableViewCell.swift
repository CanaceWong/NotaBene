//
//  ViewControllerTableViewCell.swift
//  NotaBene
//
//  Created by Christine Horrocks on 07/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var entryContentLabel: UILabel!
    @IBOutlet weak var entryTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
