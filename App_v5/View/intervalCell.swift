//
//  intervalCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class intervalCell: UITableViewCell {
    var lastHours = [Int]()
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secBtn: UIButton!
    @IBOutlet weak var hourDisplay: UILabel!
    
    
    
    
    static let identifier = "intervalCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "intervalCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getYesterday()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")  //設定時區 這個不會改
        formatter.locale = Locale.init(identifier: "zh_Hant_TW")
        let dateStr = formatter.string(from: Date() - 86400)
        return dateStr
    }
    func getToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")   //設定時區 這個不會改
        formatter.locale = Locale.init(identifier: "zh_Hant_TW")
        let today = formatter.string(from: Date())
        return today
    }
    func getLastHours() -> Int {
        lastHours.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
        for obj in data {
            lastHours.append(obj.hours)
        }
        if let last = lastHours.last {
        return last
        }
        return 0
    }
}
