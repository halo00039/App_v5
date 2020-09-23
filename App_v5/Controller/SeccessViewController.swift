//
//  SeccessViewController.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/8/2.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class SeccessViewController: UIViewController {

    @IBOutlet weak var seccessDisplay: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        seccessDisplay.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
