//
//  markCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

protocol editorBtnDelegate {
    func editorHandler()
}

class markCell: UITableViewCell {
    var delegate: editorBtnDelegate?
    static let identifier = "markCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "markCell", bundle: nil)
    }
    
    
    @IBOutlet weak var displayDate: UILabel!
    @IBOutlet weak var displayNote: UILabel!
    @IBOutlet weak var editorBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editorHandler(_ sender: UIButton) {
        delegate?.editorHandler()
    }
    let UserDefault_Daily_Check_Mark_Display = "UserDefault_Daily_Check_Mark_Display"
    let UserDefault_Markinput_Daily_Check_Key = "UserDefault_Markinput_Daily_Check_Key"
    func checkDailyMark() {
        displayDate.text = getTodayFormat()
        
        let now = Date()
        let ud = UserDefaults.standard
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let today = formatter.string(from: now)
        if ud.string(forKey: UserDefault_Daily_Check_Mark_Display) == today {
            if let data = ud.string(forKey: UserDefault_Markinput_Daily_Check_Key) {
                displayNote.text = data
            }
        } else {
            ud.set(today, forKey: UserDefault_Daily_Check_Mark_Display )
            displayNote.text = ""
        }
    }
    func getTodayFormat() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEEE"
        formatter.locale = Locale.init(identifier: "zh_Hant_TW")
        let ret = formatter.string(from: now)
        return ret
    }
    
}
