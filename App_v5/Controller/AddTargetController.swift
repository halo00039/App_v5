//
//  addTargetController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/29.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class AddTargetController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var OKBtn: UIButton!
    let User_Target_Weight_Key = "User_Target_Weight_Key"
    @IBOutlet weak var pickerView: UIPickerView!
    //data
    var firstNum = [String]()
    var secNum = [String]()
    var targetWeight = 0.0
    //Key
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        setupSubviews()
        
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
extension AddTargetController {

    func setupSubviews() {
        cancelBtn.layer.cornerRadius = 10
        OKBtn.layer.cornerRadius = 10
        pickerView.layer.cornerRadius = 25
        pickerView.backgroundColor = UIColor(patternImage: UIImage(named: "addTarget")!)
        pickerView.dataSource = self
        pickerView.delegate = self
        
        for i in 30...150 {
            firstNum.append(String(i))
        }
        for i in 0...9 {
            secNum.append(String(i))
        }
    }

    @IBAction func addTargetHandler(_ sender: UIButton) {
        let first = pickerView.selectedRow(inComponent: 0)
        let firstD = Double(first) + 30.0
        let second = pickerView.selectedRow(inComponent: 1)
        let secondD = Double(second) / 10.0
        let weight = firstD + secondD
        targetWeight = weight
        
        let ud = UserDefaults.standard
        ud.set(targetWeight, forKey: User_Target_Weight_Key)
//        print("\(weight)")
    }

    
    @IBAction func backHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
extension AddTargetController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component > 0 {
            return secNum.count
        }
        return firstNum.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component > 0 {
            return secNum[row]
        }
        return firstNum[row]
    }
    
    //返回值給WeightVIewController       先在WeightVIewController ＋ @IBAction func unwindToWeight    然後storyboard返回頁面的exit 拖拉給觸發返回按鈕
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let weightController = segue.destination as? WeightViewController
//        weightController?.targetDouble = targetWeight
//    }
}

