//
//  CellTableViewCell.swift
//  myOwnTableView
//
//  Created by chang on 2017/7/6.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var cLabel: UILabel!
    
    @IBOutlet weak var cSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
