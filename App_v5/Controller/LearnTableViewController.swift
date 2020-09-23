//
//  LearnTableViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/22.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class LearnTableViewController: UITableViewController {
    
    var titleData = [String]()
    var targetFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        setupSubviews()
        tableView.contentInset = UIEdgeInsets(top: -34.5, left: 0, bottom: 0, right: 0)
        
    }
    func initData() {
        targetFile = "\(NSHomeDirectory())/Documents/learnTitleData.plist"
        let fileMng = FileManager.default
        if !fileMng.fileExists(atPath: targetFile) {
            if let sourceFile = Bundle.main.path(forResource: "learnTitle", ofType: "plist") {
           try? fileMng.copyItem(atPath: sourceFile, toPath: targetFile)
            }
        }
    }
    func setupSubviews() {
        if let array = NSArray(contentsOfFile: targetFile) as? [String] {
           titleData = array
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = titleData[indexPath.row]
        cell.backgroundView = UIImageView(image: UIImage(named: "Cellimage"))
        cell.layer.cornerRadius = 20

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? LearnViewController
        next?.target = targetFile
        
        if let indexPath = tableView.indexPathForSelectedRow {
            next?.idx = indexPath.row
        }
    }
}
