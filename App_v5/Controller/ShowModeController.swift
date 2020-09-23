//
//  showModeController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/28.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class ShowModeController: UITableViewController {
    //判斷跑哪一個圓形進度條
    let Decide_What_Circle_Key = "Decide_What_Circle_Key"
    //記憶開關狀態
    let Check_Timer_Run_What_Key = "Check_Timer_Run_What_Key"
    
    let User_Choice_StartTime_Key = "User_Choice_StartTime_Key"
    var delegateM: MainViewController?
    var mode: Int?
    var timer: Timer?
    var back =  UIButton(type: .close)
    let days: Int = 24
    var titleArray = ["禁食14小時 休息10小時","禁食16小時 休息8小時","禁食18小時 休息6小時","禁食20小時 休息４小時","禁食22小時 休息2小時","測試"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setupSubviews() {
        tableView.register(tapModeCell.Nib(), forCellReuseIdentifier: tapModeCell.identifier)
        back.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        back.center = CGPoint(x: 25, y: 25)
        back.addTarget(self, action: #selector(closeHandler), for: .touchUpInside)
        self.view.addSubview(back)
        let dao = ModeDAO.shared
        print(dao.getAllMode())
    }
    @objc func closeHandler(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tapModeCell", for: indexPath) as? tapModeCell {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "modecell")!)
            cell.tapTitle.text = titleArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let dao = ModeDAO.shared
            if let data = dao.getModeById(1) {
                mode = data.mode
                saveMode(mode: mode!)
//                delegateM?.secs = mode
                let save = toFastingTime(mode!)
                saveToUD(save)
                let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                saveResultTimeToUD(resultTime: resultTime)
                setCheckBoolToUD()
                decideWhatCircle()
                dismiss(animated: true, completion: nil)
//                startFasting(timing: mode)
            }
        }
        if indexPath.row == 1 {
            let dao = ModeDAO.shared
            if let data = dao.getModeById(2) {
                 mode = data.mode
                saveMode(mode: mode!)
//                delegateM?.secs = mode
                let save = toFastingTime(mode!)
                saveToUD(save)
                let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                saveResultTimeToUD(resultTime: resultTime)
                setCheckBoolToUD()
                decideWhatCircle()
                dismiss(animated: true, completion: nil)
//                startFasting(timing: mode)
            }
        }
        if indexPath.row == 2 {
            let dao = ModeDAO.shared
            if let data = dao.getModeById(3) {
                mode = data.mode
                saveMode(mode: mode!)
//                delegateM?.secs = mode
                let save = toFastingTime(mode!)
                saveToUD(save)
                let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                saveResultTimeToUD(resultTime: resultTime)
                setCheckBoolToUD()
                decideWhatCircle()
                dismiss(animated: true, completion: nil)
//                startFasting(timing: mode)
            }
        }
        if indexPath.row == 3 {
            let dao = ModeDAO.shared
            if let data = dao.getModeById(4) {
                 mode = data.mode
                saveMode(mode: mode!)
//                delegateM?.secs = mode
                let save = toFastingTime(mode!)
                saveToUD(save)
                let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                saveResultTimeToUD(resultTime: resultTime)
                setCheckBoolToUD()
                decideWhatCircle()
                dismiss(animated: true, completion: nil)
//                startFasting(timing: mode)
            }
        }
        if indexPath.row == 4 {
            let dao = ModeDAO.shared
            if let data = dao.getModeById(5) {
                 mode = data.mode
                saveMode(mode: mode!)
//                delegateM?.secs = mode
                let save = toFastingTime(mode!)
                saveToUD(save)
                let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                saveResultTimeToUD(resultTime: resultTime)
                setCheckBoolToUD()
                decideWhatCircle()
                dismiss(animated: true, completion: nil)
//                startFasting(timing: mode)
            }
        }
        if indexPath.row == 5 {
                    let dao = ModeDAO.shared
                    if let data = dao.getModeById(6) {
                         mode = data.mode
                        saveMode(mode: mode!)
//                        delegateM?.secs = mode
                        let save = toFastingTime(mode!)
                        saveToUD(save)
                        let resultTime = toSaveEatingTime(fastingTime: save, mode: mode!)
                        saveResultTimeToUD(resultTime: resultTime)
                        setCheckBoolToUD()
                        decideWhatCircle()
                        dismiss(animated: true, completion: nil)
        //                startFasting(timing: mode)
                    }
                }
    }
    //斷食結束時間
    let Fasting_Timing_Key = "Fasting_Timing_Key"
    //方案幾小時
    let Mode_hours_Save_Key = "Mode_hours_Save_Key"
    func saveMode(mode: Int) {
        let ud = UserDefaults.standard
        ud.set(mode, forKey: Mode_hours_Save_Key)
    }
    
    
    func saveToUD(_ data: Date) {
        let ud = UserDefaults.standard
        ud.set(data ,forKey: Fasting_Timing_Key)
        print("ii..\(data)")
        ud.synchronize()
    }
    let Result_Time_Key = "Result_Time_Key"
    
    func saveResultTimeToUD(resultTime: Date) {
        let ud = UserDefaults.standard
        ud.set(resultTime, forKey: Result_Time_Key)
        ud.synchronize()
    }
    
    func toFastingTime(_ mode: Int) -> Date {
        let totalTime = mode * 60 * 60
        let fastingTime = TimeInterval(totalTime)
        let time = aaa() + fastingTime
        print("toFastingTime....\(time)")
        return time
    }
    
    func aaa() -> Date {
        let ud = UserDefaults.standard
         let time = ud.value(forKey: User_Choice_StartTime_Key)
        let startTime = time as? Date ?? Date()
        return startTime
    }
    
    func toSaveEatingTime(fastingTime: Date, mode: Int) -> Date {
        let time = days - mode
        let eatingTime = TimeInterval(time * 60 * 60)
        let resultTime = fastingTime + eatingTime
        print("resultTime...\(DateToTaiwanString(resultTime))")
        return resultTime
//        print("eatingTime..\(eatingTime)")
    }
    func DateToTaiwanString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let time = formatter.string(from: date)
        return time
    }
    func setCheckBoolToUD() {
        let ud = UserDefaults.standard
        ud.set(false, forKey: Check_Timer_Run_What_Key)
    }
    func decideWhatCircle() {
        let ud = UserDefaults.standard
        ud.set(false, forKey: Decide_What_Circle_Key) 
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let back = segue.destination as? MainViewController
//        back?.secs = mode
//        print(mode)
//    }
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
//    func startFasting(timing: Int) {
//        let realTiming = timing * 60 * 60
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
//            <#code#>
//        })
//    }
    //確認mode 離開時有值
    override func viewWillDisappear(_ animated: Bool) {
//        print("123")
        print(mode ?? 0)
        print("------------------------")
    }
}


