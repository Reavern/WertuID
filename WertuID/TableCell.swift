//
//  TableCell.swift
//  WertuID
//
//  Created by Reavern on 3/19/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var coordinateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
