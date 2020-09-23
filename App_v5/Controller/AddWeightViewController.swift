//
//  AddWeightViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/28.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class AddWeightViewController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var OKBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    //data
    var firstNum = [String]()
    var secNum = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //不加這個的話背景會黑畫面
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
extension AddWeightViewController {
    func setupSubviews() {
        cancelBtn.layer.cornerRadius = 10
        OKBtn.layer.cornerRadius = 10
        pickerView.layer.cornerRadius = 25
        pickerView.backgroundColor = UIColor(patternImage: UIImage(named: "pickerView")!)
        pickerView.dataSource = self
        pickerView.delegate = self
        
        for i in 30...150 {
            firstNum.append(String(i))
        }
        for i in 0...9 {
            secNum.append(String(i))
        }
    }
    
    @IBAction func addHandler(_ sender: UIButton) {
        let dao = NowWeightDAO.shared
        let firstSelected = pickerView.selectedRow(inComponent: 0)
        let firstSelectedD = Double(firstSelected) + 30.0
        let secSelected = pickerView.selectedRow(inComponent: 1)
        let secSelectedD = Double(secSelected) / 10.0
        let weight = firstSelectedD + secSelectedD
        let data = NowWeight(date: getDateInt(Date()), weight: weight)
        dao.insert(data: data)
        dismiss(animated: true, completion: nil)
 //       print(getDateInt(Date()))
    }
    
    @IBAction func backHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDateInt(_ date: Date) -> Int {
        let ret: Int?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let retStr = formatter.string(from: date)
        ret = Int(retStr)
        return ret ?? 0
    }
}

extension AddWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
}
