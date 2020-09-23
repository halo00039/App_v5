//
//  modeCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

protocol modeBtnDeleGate {
    func setModeHandler()
}

class modeCell: UITableViewCell {
    var delegate: modeBtnDeleGate?

    static let identifier = "modeCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "modeCell", bundle: nil)
    }
    
//UI
    @IBOutlet weak var modeChoiceAndDisplay: UIButton!
    @IBOutlet weak var startOrStopBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        modeChoiceAndDisplay.setTitle("123456", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setModeHandler(_ sender: UIButton) {
        delegate?.setModeHandler()
    }
    
    
}
