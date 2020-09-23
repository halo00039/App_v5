//
//  MainViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    //模式開關 開或關
    let Mode_Button_On_Or_Off = "Mode_Button_On_Or_Off"
    //記憶開關狀態
    let Check_Timer_Run_What_Key = "Check_Timer_Run_What_Key"
    let Save_Second_Timer_Key = "Save_Second_Timer_Key"
//    var startTime = ""
//    var secs: Int? = 0
    
    let UserDefault_Markinput_Daily_Check_Key = "UserDefault_Markinput_Daily_Check_Key"
    let Mode_hours_Save_Key = "Mode_hours_Save_Key"
    //from setStartTimeController 存的是開始按鈕的開始時間
    let User_Choice_StartTime_Key = "User_Choice_StartTime_Key"
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print("123")
//
//       let dao = ModeDAO.shared
        
//        print(dao.getAllMode().count)
//        print(dao.getModeById(7))
//        let dao = NowWeightDAO.shared
//        print(dao.getAllWeights())
//        if let data = dao.getWeightById(1) {
//        dao.insert(data: data)
//        }
//        print(dao.getAllWeights().count)
        // test DB line--------------------------
        
        
        
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "APP_BackGround")!)
        
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        
        tableView.register(CircleCell.Nib(), forCellReuseIdentifier: CircleCell.identifier)
        tableView.register(modeCell.Nib(), forCellReuseIdentifier: modeCell.identifier)
        tableView.register(bloodCell.Nib(), forCellReuseIdentifier: bloodCell.identifier)
        tableView.register(intervalCell.Nib(), forCellReuseIdentifier: intervalCell.identifier)
        tableView.register(markCell.Nib(), forCellReuseIdentifier: markCell.identifier)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > 3 {
            if let markCell = tableView.dequeueReusableCell(withIdentifier: "markCell", for: indexPath) as? markCell {
                markCell.delegate = self
                markCell.checkDailyMark()
                return markCell
            }
        }
        
        if indexPath.row > 2 {
            if let intervalCell = tableView.dequeueReusableCell(withIdentifier: "intervalCell", for: indexPath) as? intervalCell {
                intervalCell.firstBtn.setTitle(intervalCell.getYesterday(), for: .normal)
                intervalCell.secBtn.setTitle(intervalCell.getToday(), for: .normal)
                intervalCell.hourDisplay.text = "\(intervalCell.getLastHours()) 小時"
                return intervalCell
            }
        }
        
        if indexPath.row > 1 {
            if let bloodCell = tableView.dequeueReusableCell(withIdentifier: "bloodCell", for: indexPath) as? bloodCell {
                bloodCell.bloodBtn.layer.cornerRadius = 20
                bloodCell.delegate = self
                return bloodCell
            }
        }
        
        if indexPath.row > 0 {
           if let modeCell = tableView.dequeueReusableCell(withIdentifier: "modeCell", for: indexPath) as? modeCell {
            modeCell.delegate = self
            let ud = UserDefaults.standard
            if ud.bool(forKey: Mode_Button_On_Or_Off) == true {
                modeCell.modeChoiceAndDisplay.isEnabled = true
            } else {
                modeCell.modeChoiceAndDisplay.isEnabled = false
            }
                return modeCell
            }
        }
        
            
            if let circleCell = tableView.dequeueReusableCell(withIdentifier: "CircleCell", for: indexPath) as? CircleCell {
                let ud = UserDefaults.standard
                circleCell.delegateM = self
                circleCell.delegate = self
                circleCell.stopTime()
                circleCell.circleDisplay.backgroundColor = UIColor(patternImage: UIImage(named: "circleBackground")!)
                
                circleCell.showStartTime()
                circleCell.setEndTime()
                if ud.bool(forKey: Save_Second_Timer_Key) == true {
                    circleCell.promptDisplay.isHidden = false
                    circleCell.StopOrStartBtn.isEnabled = false
                    circleCell.setTimeBtn.isEnabled = true       //測試時要調成true  完成後改掉
                } else {
                    circleCell.promptDisplay.isHidden = true
                    circleCell.StopOrStartBtn.isEnabled = true
                    circleCell.setTimeBtn.isEnabled = true
                }
                
                if ud.bool(forKey: Save_Second_Timer_Key) == false {
                    circleCell.fire()
                    print("第一個")
                } else {
                    circleCell.fireByAlreadyTapStop()
                    print("第二個")
                }

                
//                navigationItem.title = "斷食中"
                return circleCell
            }
        return UITableViewCell()
    }
    @objc func stopOrStartHandler() {
        print("objc test")
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 3 {
            return 200
        }
        
        if indexPath.row > 1 {
            return 150
        }
        
        if indexPath.row > 0 {
            return 100
        }
        return 484
    }
    
    let Fasting_Timing_Key = "Fasting_Timing_Key"
    let Result_Time_Key = "Result_Time_Key"
    
    func getFromUD(key: String) -> Date {
        let ud = UserDefaults.standard
        if let time = ud.value(forKey: key) {
            return time as? Date ?? Date()
        }
        return Date()
    }
    func getResultTimeFromUD(key: String) -> Date {    //修改過＊＊＊＊＊＊＊＊＊＊＊＊
        let ud = UserDefaults.standard        //Result_Time_Key
        if let resultTime = ud.value(forKey: key) {
            return resultTime as? Date ?? Date()
        }
        return Date()
    }
//    轉成台灣時間 String
    func DateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let time = formatter.string(from: date)
        return time
    }
    
    func timeCalculation(targetTime: Date) -> Int {
//        let now = Date()
        let startTime = getFromUD(key: User_Choice_StartTime_Key)
        let fasting = targetTime.timeIntervalSince(startTime)
        let fastingTime = Int(fasting)
        return fastingTime
    }
    
    func resultTimeCalculation(resultTime: Date) -> Int {
        let now = Date()
        let resultSecsT = resultTime.timeIntervalSince(now)
        let resultSecs = Int(resultSecsT)
        return resultSecs
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        tableView.reloadData()
        let ud = UserDefaults.standard
        ud.set(false, forKey: Save_Second_Timer_Key)
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

//跳到選擇方案頁面 cell -> MainViewController
extension MainViewController: modeBtnDeleGate,editorBtnDelegate,UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func editorHandler() {
        let alert = UIAlertController(title: "新增備註", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "請輸入"
            textField.clearButtonMode = .always
            textField.delegate = self
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let ok = UIAlertAction(title: "確定", style: .default) { (action) in
            let markInput = alert.textFields?[0].text
            let ud = UserDefaults.standard
            ud.set(markInput, forKey: self.UserDefault_Markinput_Daily_Check_Key)
            self.tableView.reloadData()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func setModeHandler() {
        if let next = self.storyboard?.instantiateViewController(identifier: "setModeTableView") as? ShowModeController {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            next.delegateM = self
            present(next, animated: true, completion: nil)
        }
    }
//    func getMarkToDB(data: FastingList) {
//        let ud = UserDefaults.standard
//        let mark = ud.string(forKey: UserDefault_Markinput_Daily_Check_Key)
//        let dao = FastingListDAO.shared
//        dao.insert(data: data)
//    }
}
// ciecleCell 跳頁的delegate, 設定開始時間的跳頁
extension MainViewController: toSuccessViewDelegate,BloodDalegate{
    func alertMessage() {
        
//        let ud = UserDefaults.standard
//        let mode = ud.integer(forKey: Mode_hours_Save_Key)
//        let totalTime = TimeInterval(mode * 60 * 60)
//        let startTime = getResultTimeFromUD(key: User_Choice_StartTime_Key)
//        let flagTime = startTime + totalTime
//
//        if flagTime.timeIntervalSince(Date()) > 0 {
//            let alert = UIAlertController(title: "要終止斷食嗎？", message: "連續紀錄將中斷！", preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            alert.addAction(cancel)
//            let ok = UIAlertAction(title: "確定", style: .default) { (action) in
//                timer?.invalidate()
//            }
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//
//        } else {
//            let alert = UIAlertController(title: "要開始斷食嗎？", message: nil, preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            alert.addAction(cancel)
//            let ok = UIAlertAction(title: "確定", style: .default) { (action) in
//                // 提前開始斷食
//            }
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//        }
    }
    
    func toBloodView() {
        if let next = self.storyboard?.instantiateViewController(identifier: "BloodViewController") as? BloodViewController {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            present(next, animated: true, completion: nil)
        }
    }
    
    
    func setTitleToStop() {
        navigationItem.title = "斷食中"
    }
    
    func setTitleToEat() {
        navigationItem.title = "進食中"
    }
    
    func setStartTime() {
        if let next = self.storyboard?.instantiateViewController(identifier: "SetStartTimeController") as? SetStartTimeController {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            
            next.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            present(next, animated: true, completion: nil)
        }
    }
    
    
}

