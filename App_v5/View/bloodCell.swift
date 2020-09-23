//
//  bloodCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

protocol BloodDalegate {
    func toBloodView()
}

class bloodCell: UITableViewCell {
    var delegate: BloodDalegate?
    static let identifier = "bloodCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "bloodCell", bundle: nil)
    }
    
    @IBAction func bloodHandler(_ sender: UIButton) {
        delegate?.toBloodView()
        print("bloodHandler")
    }
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var bloodBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
}
