//
//  RecordViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/27.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class RecordViewController: UITableViewController {
    //最佳連續天數
    let Continuous_Days_Best_Key = "Continuous_Days_Best_Key"
    //連續天數
    let Continuous_Days_Now_Key = "Continuous_Days_Now_Key"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        tableView.register(RecordViewCell.Nib(), forCellReuseIdentifier: RecordViewCell.identifier)
        tableView.register(record2Cell.Nib(), forCellReuseIdentifier: record2Cell.identifier)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > 0 {
            if let record2Cell = tableView.dequeueReusableCell(withIdentifier: "record2Cell", for: indexPath) as? record2Cell {
                record2Cell.delegate = self
                record2Cell.updateData()
                record2Cell.fastingDaysNow.text = "\(getContinousDays())"
                record2Cell.bestFastingDays.text = "\(getBestContinousDays())"
                return record2Cell
            }
        }
        
        if let RecordViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordViewCell", for: indexPath) as? RecordViewCell {
            RecordViewCell.delegateR = self
            RecordViewCell.upDateDataToShow()
            return RecordViewCell
        } else {
            return UITableViewCell()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return 400
        }
        return 460
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
extension RecordViewController: showTimeListDelegate {
    func showTimeListHandler() {
        if let next = self.storyboard?.instantiateViewController(identifier: "timeList") {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            present(next, animated: true, completion: nil)
        }
    }
    
    
}
extension RecordViewController {
    func setupSubviews() {
//        let dao = FastingListDAO.shared
//        print(dao.getLastData())
        
    }
    func getContinousDays() -> Int {
        let ud = UserDefaults.standard
        let days = ud.integer(forKey: Continuous_Days_Now_Key)
        return days
    }
    func getBestContinousDays() -> Int {
        let ud = UserDefaults.standard
        let days = ud.integer(forKey: Continuous_Days_Best_Key)
        return days
    }
}
