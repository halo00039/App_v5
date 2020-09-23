//
//  CircleCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/26.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

protocol toSuccessViewDelegate {
    func setStartTime()
    func setTitleToStop()
    func setTitleToEat()
    func alertMessage()
}


class CircleCell: UITableViewCell {
    var delegate: toSuccessViewDelegate?
    var delegateM: MainViewController?
//    var delegateR: RecordViewController?
    var endTime: Date? = Date()
    
    var timer: Timer?
    var eatingTimer: Timer?
    var circleTimer: Timer?
//    var secs: Int = 0
    //模式開關 開或關
    let Mode_Button_On_Or_Off = "Mode_Button_On_Or_Off"
    //判斷跑哪一個圓形進度條
    let Decide_What_Circle_Key = "Decide_What_Circle_Key"
    //最佳連續天數
    let Continuous_Days_Best_Key = "Continuous_Days_Best_Key"
    //連續天數
    let Continuous_Days_Now_Key = "Continuous_Days_Now_Key"
    //今日備註
    let UserDefault_Markinput_Daily_Check_Key = "UserDefault_Markinput_Daily_Check_Key"
    //禁食結束時間
    let Fasting_Timing_Key = "Fasting_Timing_Key"
    //總結束時間
    let Result_Time_Key = "Result_Time_Key"
    //開始時間
    let User_Choice_StartTime_Key = "User_Choice_StartTime_Key"
    //方案幾小時
    let Mode_hours_Save_Key = "Mode_hours_Save_Key"
    //記憶開關狀態
    let Check_Timer_Run_What_Key = "Check_Timer_Run_What_Key"
    @IBOutlet weak var setTimeBtn: UIButton!
    @IBOutlet weak var endTimeDisplay: UILabel!
    @IBOutlet weak var modeDisplay: UILabel!
    @IBOutlet weak var promptDisplay: UILabel!
    
    @IBOutlet weak var StopOrStartBtn: UIButton!
    
    @IBOutlet weak var timeDisplay: UILabel!
    static let identifier = "CircleCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "CircleCell", bundle: nil)
    }

    @IBOutlet weak var circleDisplay: UIView!
    let  shapeLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        circleDisplay.backgroundColor = UIColor.lightGray
 //       circleDisplay.center = self.center
        let center = CGPoint(x: self.center.x, y: self.center.y + 35)
        
        //        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 145.0, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
                // 灰色外誆
                let trackLayer = CAShapeLayer()
                
                trackLayer.path = circularPath.cgPath
                trackLayer.strokeColor = UIColor.lightGray.cgColor
                trackLayer.lineWidth = 15
                trackLayer.lineCap = .round
                trackLayer.fillColor = UIColor.clear.cgColor
                
        //        self.view.layer.addSublayer(trackLayer)
                circleDisplay.layer.addSublayer(trackLayer)
                
                //藍色外誆
                shapeLayer.path = circularPath.cgPath
                shapeLayer.strokeColor = UIColor.blue.cgColor
                shapeLayer.lineWidth = 15
                shapeLayer.lineCap = .round
                shapeLayer.fillColor = UIColor.clear.cgColor
                
                shapeLayer.strokeEnd = 0
                
                
        //        view.layer.addSublayer(shapeLayer)
        //        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
                circleDisplay.layer.addSublayer(shapeLayer)
//                circleDisplay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
                
            }
    

    func startCircle(duration: TimeInterval,value: Float,fromValue: Float) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = value
        basicAnimation.duration = duration
        basicAnimation.fromValue = fromValue * 0.8
    //    basicAnimation.fromValue = 0
        shapeLayer.add(basicAnimation, forKey: "myCircle")
    }
    
    
//            @objc func tapHandler() {
//        //        print("tap...")
//                let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//                basicAnimation.toValue = 0.8
//                basicAnimation.duration = 1200
//                shapeLayer.add(basicAnimation,forKey: "urSoBasic")
//            }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }

    func startFasting(secs: Int) {
 //       delegate?.startFasting(secsf)
        let ud = UserDefaults.standard
        var sec = secs
        modeDisplay.text = "斷食\(showMode())小時"
//        var sec = 5


//        let secs = 50
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            if sec <= 0 {
                //開始進食窗口邏輯 或 存取資料
                print("secTimerStart")
                print("secs...\(self.calculateEatingTime())")
                ud.set(true, forKey: self.Check_Timer_Run_What_Key)
                self.startEatingTimer(sec: self.calculateEatingTime())
                self.StopOrStartBtn.isEnabled = true
                t.invalidate()
    
                let data = FastingList(date: self.DateToDBString(Date()), hours: self.getDBHours() , mark: self.getMarkFromUD(), bool: 1)
                if secs == 0 {
                    return
                }
                self.insertToDB(data: data)
                self.checkContinuousDaysAndSave()
                //模式可不可按 ＝> 不可
                ud.set(false, forKey: self.Mode_Button_On_Or_Off)
                print("save seccess...")
                
                return
            }
  //          self.setTimeBtn.isEnabled = false
            sec -= 1
            self.setTimeFormat(secs: sec)
            self.setTitleToStop()
            self.StopOrStartBtn.setTitle("提早進入進食期！", for: .normal)
//            self.StopOrStartBtn.isEnabled = false
//            self.promptDisplay.isHidden = false
        })
  //      timer?.fire()
    }
    func setTimeFormat(secs: Int) {
        let hour = secs / 3600
        let min = secs % 3600 / 60
        let sec = secs % 3600 % 60
        timeDisplay.text = "\(String(format: "%02d", hour)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
    }
    
    @objc func fire() {
//        getStartTime()
//        getEndTime()
//        getResultTime()
        let ud = UserDefaults.standard
        
//        openBtn()
//        stopTime()
        if ud.bool(forKey: Check_Timer_Run_What_Key ) == false {
            startFasting(secs: calculateTime())
            print(ud.bool(forKey: Decide_What_Circle_Key))
            if ud.bool(forKey: Decide_What_Circle_Key) == false {
            startCircle(duration: TimeInterval(calculateTime()), value: 0.8, fromValue: checkCirclePosition())
            } else {
                startCircle(duration: TimeInterval(self.calculateEatingTime()), value: 0.8, fromValue: self.alreadtTapCircleStartPosition())
            }
        } else {
            startEatingTimer(sec: calculateEatingTime())
            setTimeBtn.isEnabled = true
            
        }
        
    }
    func startEatingTimer(sec: Int) {
        let ud = UserDefaults.standard
        var secs = sec
        eatingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (tt) in
            if secs <= 0 {
                tt.invalidate()
                ud.set(false, forKey: self.Check_Timer_Run_What_Key)
                self.modeDisplay.text = "請設定今日的開始時間！"
                //設定模式按鈕可按
                ud.set(true, forKey: self.Mode_Button_On_Or_Off)
                return
            }
            self.modeDisplay.text = "進食時間"
            secs -= 1
            self.setTimeFormat(secs: secs)
            self.setTitleToEat()
            self.StopOrStartBtn.setTitle("現在開始斷食！", for: .normal)
        })
    }
    
    func showMode() -> Int {
        let ud = UserDefaults.standard
        let mode = ud.integer(forKey: Mode_hours_Save_Key)
        return mode
    }
    
    func calculateEatingTime() -> Int {
        let resultTime = getResultTime()
        let twTime = DateToTaiwanString(resultTime)
        print("結束時間...\(twTime)")
        let timeT = resultTime.timeIntervalSince(Date())
        let time = Int(timeT)
        print("秒數...\(time)")
        return Int(time)
    }
    
    func calculateTime() -> Int {
//        let start = getStartTime()
        let end = getEndTime()
        print("結束時間..\(DateToTaiwanString(end))")
        let timeT = end.timeIntervalSince(Date())
        let time = Int(timeT)
        return time
    }

    func getStartTime() -> Date  {
        let _startTime = getFromUDtoDate(key: User_Choice_StartTime_Key)
        return _startTime
    }
    func getEndTime() -> Date {
        let ud = UserDefaults.standard
        let mode = ud.integer(forKey: Mode_hours_Save_Key)
        let totalTime = TimeInterval(mode * 60 * 60)
        let time = getFromUDtoDate(key: User_Choice_StartTime_Key)
        let result = time + totalTime
        return result
    }
    func getResultTime() -> Date {
        let _startTime = getFromUDtoDate(key: User_Choice_StartTime_Key)
        let day = TimeInterval(24 * 60 * 60)
        let time = _startTime + day
        return time
    }
    
    func getFromUD() -> Int {
        let ud = UserDefaults.standard
        let nums = ud.integer(forKey: Fasting_Timing_Key)
            return nums
    }
    
    func stopTime() {
        timer?.invalidate()
        eatingTimer?.invalidate()
    }
    func openBtn() {
        setTimeBtn.isEnabled = true
        StopOrStartBtn.isEnabled = true
    }
    //這邊設定圓的初始位置
    func checkCirclePosition() -> Float {
        let endTime = getEndTime()
        let secsOne = endTime.timeIntervalSince(Date())
        let totalTime = getStartToEndSecs()
        let secsT = Float(totalTime) - Float(secsOne)
        let position = secsT / Float(totalTime)
        return position
    }
    //給圓環進度條的秒數 計算百分比用
    func getStartToEndSecs() -> Int {
        let startTime = getStartTime()
        let endTime = getEndTime()
        let totalSecs = endTime.timeIntervalSince(startTime)
        return Int(totalSecs)
    }
    //第二次斷食的結束時間 算第二個斷時計時器圓的起始位置   
    func alreadtTapCircleStartPosition() -> Float {
        let ud = UserDefaults.standard
//        let startTime = getResultTime()   //開始時間
        let mode = ud.integer(forKey: self.Mode_hours_Save_Key)
        let totalTime = TimeInterval(mode * 60 * 60)
        let endTime = self.getResultTime() + totalTime    //結束時間
        let totalSecs = ud.integer(forKey: Second_Circle_TotalSecs_Key)
        let secOne = endTime.timeIntervalSince(Date())  //開始時間對比結束時間
        let secT = Float(totalSecs) - Float(secOne) //總時間 － 對比出來的時間
        let position = Float(secT) / Float(totalSecs)
        print("secOne...\(secOne)")
        print("secT...\(secT)")
        print("position....\(position)")
        return position
        }
    let Second_Circle_TotalSecs_Key = "Second_Circle_TotalSecs_Key"
    func getStartToEndSecsForSecond()  {
        let ud = UserDefaults.standard
        let mode = ud.integer(forKey: self.Mode_hours_Save_Key)
        let totalTime = TimeInterval(mode * 60 * 60)
        let resultTime = getResultTime() + totalTime
        let totalSecs = resultTime.timeIntervalSince(Date()) //總秒數
        ud.set(Int(totalSecs), forKey: Second_Circle_TotalSecs_Key)
         
    }
    
    
    //這邊以下 設定開始結束時間
    
    @IBAction func setStartTimeHandler(_ sender: UIButton) {
        delegate?.setStartTime()
    }
    
    func showStartTime() {
        let _startTime = getFromUDtoDate(key: User_Choice_StartTime_Key)
        let startTime = DateToTaiwanString(_startTime)

        setTimeBtn.setTitle(startTime, for: .normal)
       }
    func getFromUDtoDate(key: String) -> Date { //*********************************
        let ud = UserDefaults.standard
        if let time = ud.value(forKey: key) {
            return time as? Date ?? Date()
        }
        return Date()
    }
    func getFromDBtoDate(dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = formatter.date(from: dateStr)
        return date ?? Date()
    }
    func DateToTaiwanString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let time = formatter.string(from: date)
        return time
    }
    func DateToDBString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let time = formatter.string(from: date)
        return time
    }
    
    func setEndTime() {
        let ud = UserDefaults.standard
        let mode = ud.integer(forKey: Mode_hours_Save_Key)
        let totalTime = TimeInterval(Int(mode) * 60 * 60)
        let time = getFromUDtoDate(key: User_Choice_StartTime_Key)
        let result = time + totalTime
        let finalDisplay = DateToTaiwanString(result)
        endTimeDisplay.text = finalDisplay
    }
    // 設定title
    func setTitleToStop() {
        delegate?.setTitleToStop()
    }
    func setTitleToEat() {
        delegate?.setTitleToEat()
    }
    //startOrStopButton
    
    @IBAction func stopOrStartHandler(_ sender: UIButton) {
//        delegate?.alertMessage()
        let ud = UserDefaults.standard
        if ud.bool(forKey: Check_Timer_Run_What_Key) == false {
        let alert = UIAlertController(title: "要終止斷食嗎？", message: "連續紀錄將中斷！", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    let ok = UIAlertAction(title: "確定", style: .default) { (action) in
                        //中斷儲存
                        let data = FastingList(date: self.DateToDBString(Date()), hours: self.getDBStopHours() , mark: self.getMarkFromUD(), bool: 0)
                        self.insertToDB(data: data)
                        //開始進食
                        ud.set(true, forKey: self.Check_Timer_Run_What_Key)
                        self.stopTime()
                        self.fire()
                        //存取資料 連續天數 最高連續天數
                        self.checkContinuousDaysAndSave()
                        // 吃飯時間時間條
                        self.startCircle(duration: 1, value: 0.8, fromValue: 0.99)
                        //設定模式 可不可按
                        ud.set(false, forKey: self.Mode_Button_On_Or_Off)
                        self.delegateM?.tableView.reloadData()
                    }
                    alert.addAction(ok)
        delegateM?.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "直接開始斷食！", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancel)
            let ok = UIAlertAction(title: "確定", style: .default) { (action) in
                //開始斷食
                self.stopTime()
                ud.set(false, forKey: self.Check_Timer_Run_What_Key)
                
                self.StopOrStartBtn.isEnabled = false
                self.promptDisplay.isHidden = false
                self.fireByAlreadyTapStop()
                self.getStartToEndSecsForSecond()
                self.startCircle(duration: TimeInterval(self.calculateEatingTime()), value: 0.8, fromValue: self.alreadtTapCircleStartPosition())//抓第二個圓的總秒數 只有按下直接斷食按鈕 會記錄這一次的時間
                ud.set(true, forKey: self.Decide_What_Circle_Key)
                //設定模式按鈕可按
                ud.set(true, forKey: self.Mode_Button_On_Or_Off)
                self.delegateM?.tableView.reloadData()
            }
            alert.addAction(ok)
            delegateM?.present(alert, animated: true, completion: nil)
        }
    }
    let Save_Second_Timer_Key = "Save_Second_Timer_Key"
    func AlreadyTapToCircle() -> Int {
        let ud = UserDefaults.standard
        ud.set(true, forKey: Save_Second_Timer_Key)
        let mode = ud.integer(forKey: self.Mode_hours_Save_Key)
        let totalTime = TimeInterval(mode * 60 * 60)
        let time = self.getResultTime() + totalTime
        let resultTime = time.timeIntervalSince(Date())
        return Int(resultTime)
    }
    func fireByAlreadyTapStop() {
        let ud = UserDefaults.standard
        ud.set(true, forKey: Save_Second_Timer_Key)
        let mode = ud.integer(forKey: self.Mode_hours_Save_Key)
        let totalTime = TimeInterval(mode * 60 * 60)
        let time = self.getResultTime() + totalTime
        let resultTime = time.timeIntervalSince(Date())
        self.startFasting(secs: Int(resultTime))
        let display = Date() + resultTime
        let endTime = DateToTaiwanString(display)
        endTimeDisplay.text = endTime
        
        //觀察這邊 第二個圓進度條
        if ud.bool(forKey: Decide_What_Circle_Key) == false {
        startCircle(duration: TimeInterval(calculateTime()), value: 0.8, fromValue: checkCirclePosition())
        } else {
            startCircle(duration: TimeInterval(self.calculateEatingTime()), value: 0.8, fromValue: self.alreadtTapCircleStartPosition())
        }
//        print(self.alreadtTapCircleStartPosition())
    }
    // 下面為DB要的資料
    func insertToDB(data: FastingList) {
        let dao = FastingListDAO.shared
        dao.insert(data: data)
    }
    // mark
    func getMarkFromUD() -> String {
        let ud = UserDefaults.standard
        if let mark = ud.string(forKey: UserDefault_Markinput_Daily_Check_Key) {
            return mark
        }
        return ""
    }
    func getDBHours() -> Int {
        let startTime = getStartTime()
        let endTime = getEndTime()
        let hours = endTime.timeIntervalSince(startTime)
        return Int(hours) / 3600
    }
    func getDBStopHours() -> Int {
        let startTime = getStartTime()
        let endTime = getEndTime()
        let totalSecs = endTime.timeIntervalSince(startTime)
        let runSecs = endTime.timeIntervalSince(Date())
        let toDBSecs = Int(totalSecs - runSecs)
        let hours = toDBSecs / 3600
        return hours
    }
    // continues days
    func checkContinuousDaysAndSave() {
        let ud = UserDefaults.standard
        let dao = FastingListDAO.shared
        let lastData = dao.getLastData()
        if let dateStr = lastData?.date {
        let date = getFromDBtoDate(dateStr: dateStr)
            if Date().timeIntervalSince(date) < 86401 {
                var days = getContinuousDaysFromUD()
                days += 1
                ud.set(days, forKey: Continuous_Days_Now_Key)
            } else {
                setContinuousDaysToZero()
            }
        }
        compareDays()
    }
    func setContinuousDaysToZero() {
        let ud = UserDefaults.standard
        let day = 0
        ud.set(day, forKey: Continuous_Days_Now_Key)
        
    }
    func getBestContinuous(days: Int) -> Int {
        let ud = UserDefaults.standard
        let bDays = ud.integer(forKey: Continuous_Days_Best_Key)
        return bDays
    }
    func getContinuousDaysFromUD() -> Int {
        let ud = UserDefaults.standard
        let cDays = ud.integer(forKey: Continuous_Days_Now_Key)
        return cDays
    }
    func compareDays() {
        let ud = UserDefaults.standard
        let nowDays = ud.integer(forKey: Continuous_Days_Now_Key)
        let bestDays = ud.integer(forKey: Continuous_Days_Best_Key)
        if nowDays > bestDays {
            ud.set(nowDays, forKey: Continuous_Days_Best_Key)
        }
    }
}

    
    

