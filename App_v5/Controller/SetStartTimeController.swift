//
//  SetStartTimeController.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/8/2.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class SetStartTimeController: UIViewController {
    //UI
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var OKBtn: UIButton!
    @IBOutlet weak var titleDisplay: UILabel!
    var timeStr = ""
    var timeDate: Date?
    
    
    let User_Choice_StartTime_Key = "User_Choice_StartTime_Key"
    //存選擇的開始時間
    let Update_Start_Btn_Time_Key = "Update_Start_Btn_Time_Key"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom  // 防止黑畫面
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
//初始化
extension SetStartTimeController {
    func setupSubviews() {
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Date() - TimeInterval(21600)
        datePicker.backgroundColor = UIColor(patternImage: UIImage(named: "white")!)
        datePicker.layer.cornerRadius = 25
        datePicker.clipsToBounds = true
        titleDisplay.layer.backgroundColor = UIColor(red: 169, green: 169, blue: 169, alpha: 1).cgColor
        titleDisplay.layer.cornerRadius = 8
        cancelBtn.layer.cornerRadius = 10
        OKBtn.layer.cornerRadius = 10
//        let ud = UserDefaults.standard
//        let sTime = ud.value(forKey: User_Choice_StartTime_Key)
//        let time = sTime as? Date ?? Date()
//        datePicker.date = time

    }
    @IBAction func backHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setHandler(_ sender: UIButton) {
        let time = datePicker.date
        timeStr = toStringFormat(date: time)
        print(timeStr)
        let ud = UserDefaults.standard
        ud.set(time, forKey: User_Choice_StartTime_Key)
        dismiss(animated: true, completion: nil)
    }
    func toStringFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
//        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let ret = formatter.string(from: date)
        return ret
    }
    func stringToDate(dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
        let ret = formatter.date(from: dateStr)
        return ret ?? Date()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let main = segue.destination as? MainViewController {
//            main.startTime = timeStr
//            print("prepare...\(timeStr)")
//        }
//    }
    
    @IBAction func datePickerHandler(_ sender: UIDatePicker) {
        let time = datePicker.date
        let ud = UserDefaults.standard
        ud.set(time, forKey: Update_Start_Btn_Time_Key)
        timeStr = toStringFormat(date: time)
        print(timeStr)
        
    }
  
}



