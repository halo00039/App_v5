//
//  showTimeListController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/28.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class ShowTimeListController: UITableViewController {
    let Mode_hours_Save_Key = "Mode_hours_Save_Key"
    let close = UIButton(type: .close)
    var dataList = [FastingList]()
    var modeArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        tableView.register(timeListCell.Nib(), forCellReuseIdentifier: timeListCell.identifier)
    }
    @objc func closeHandler() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timeListcell = tableView.dequeueReusableCell(withIdentifier: "timeListCell", for: indexPath) as? timeListCell {
            var display = ""
            if dataList[indexPath.row].bool == 0 {
                display = "中斷"
            } else {
                display = "完成"
            }
            timeListcell.modeDisplay.text = "斷食\(dataList[indexPath.row].hours)小時  狀態: \(display)"
            timeListcell.dateDisplay.text = "\(dataList[indexPath.row].date) 結束"
            timeListcell.markDisplay.text = "\(dataList[indexPath.row].mark)"
            return timeListcell
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ShowTimeListController {
    func setupSubviews() {
        close.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        close.center = CGPoint(x: 30, y: 30)
        self.view.addSubview(close)
        close.addTarget(self, action: #selector(closeHandler), for: .touchUpInside)
        getDataArrayFromDB()
    }
    func getDataArrayFromDB() {
        dataList.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
        for obj in data {
            dataList.append(obj)
        }
    }
    func toDateFromString(dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let time = formatter.date(from: dateStr) {
            return time
        }
        return Date()
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    func getMode() -> Int {
        let ud = UserDefaults.standard
        let mode = ud.integer(forKey: Mode_hours_Save_Key)
        return Int(mode)
    }
}
