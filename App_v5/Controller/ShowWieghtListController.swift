//
//  showWieghtListController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/28.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class ShowWieghtListController: UITableViewController {
    var list = [NowWeight]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    func setupSubviews() {
        let dao = NowWeightDAO.shared
        list = dao.getAllWeights()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightDataCell", for: indexPath)
        let dateStr = list[indexPath.row].date
        let date = stringToDate(String(dateStr))
        cell.textLabel?.text = "\(list[indexPath.row].wid). \(dateFormate(date))"
        cell.detailTextLabel?.text = "\(list[indexPath.row].weight) KG"
        return cell
    }
    func stringToDate(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.date(from: string)
        return date ?? Date()
    }
    
    func dateFormate(_ date: Date) -> String {
        let ret: String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 MM 月 dd 日"
        ret = formatter.string(from: date)
        return ret
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
