//
//  record2Cell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/27.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

var hoursArray = [Int]()

protocol showTimeListDelegate {
    func showTimeListHandler()
}


class record2Cell: UITableViewCell {
    var delegate: showTimeListDelegate?
    
    static let identifier = "record2Cell"
    static func Nib() -> UINib {
        return UINib(nibName: "record2Cell", bundle: nil)
    }
    //UI
    @IBOutlet weak var fastingDaysNow: UILabel!
    @IBOutlet weak var bestFastingDays: UILabel!
    @IBOutlet weak var totalDays: UILabel!
    @IBOutlet weak var highestHours: UILabel!
    @IBOutlet weak var shortestHours: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showTimeListHandler(_ sender: UIButton) {
        delegate?.showTimeListHandler()
    }
    func updateData() {
        getDBDataToShowDays()
        getDBToShowHours()
    }
    func getDBDataToShowDays() {
//        daysArray.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
        totalDays.text = "\(data.count)"
    }
    func getDBToShowHours() {
        hoursArray.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
        for obj in data {
            hoursArray.append(obj.hours)
        }
        let highest = hoursArray.max()
        let shortest = hoursArray.min()
        highestHours.text = "\(highest ?? 0) "
        shortestHours.text = "\(shortest ?? 0) "
    }
}
