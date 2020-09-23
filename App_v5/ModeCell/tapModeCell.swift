//
//  tapModeCell.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/7/30.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class tapModeCell: UITableViewCell {
    
    static let identifier = "tapModeCell"
    static func Nib() -> UINib {
        return UINib(nibName: "tapModeCell", bundle: nil)
    }
    
    @IBOutlet weak var tapTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
