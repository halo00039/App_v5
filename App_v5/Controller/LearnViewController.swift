//
//  LearnViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/23.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    //UI
    @IBOutlet weak var titleDisplay: UILabel!
    @IBOutlet weak var textDisplay: UITextView!
    //Data
    var target = ""
    var titleData = [String]()
    var idx = -1
    //db
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "APP_LearnPage_BackGround")!)
        setupSubviews()
        getDbData()
    }
    func getDbData() {
        let dao = LearnTextDAO.shared
        if idx != -1 {
            if let data = dao.getAllTextById(fid: idx + 1) {
                textDisplay.text = data.text
            }
            
        }
    }
    func setupSubviews() {
        
        if let array = NSArray(contentsOfFile: target) as? [String] {
            titleData = array
        }
        if idx != -1 {
            titleDisplay.text = titleData[idx]
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
