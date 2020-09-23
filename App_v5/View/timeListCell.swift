//
//  timeListCell.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/8/4.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class timeListCell: UITableViewCell {
    
    static let identifier = "timeListCell"
    static func Nib() -> UINib {
        return UINib(nibName: "timeListCell", bundle: nil)
    }
    
    @IBOutlet weak var modeDisplay: UILabel!
    @IBOutlet weak var dateDisplay: UILabel!
    
    @IBOutlet weak var markDisplay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
