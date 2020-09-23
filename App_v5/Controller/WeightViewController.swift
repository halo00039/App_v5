//
//  WeightViewController.swift
//  App
//
//  Created by 葉上輔 on 2020/7/27.
//  Copyright © 2020 YehSF. All rights reserved.
//
//import Charts
import UIKit
import Charts
class WeightViewController: UIViewController, ChartViewDelegate {
    var chartView = LineChartView()
    var weightArrayToShow = [Double]()
    var dateStrArray = [String]()
    let User_Target_Weight_Key = "User_Target_Weight_Key"
//    var lineChart = LineChartView()
//    var targetDouble = 0.0
    @IBOutlet weak var addWeightBtn: UIButton!
    @IBOutlet weak var targetBtn: UIButton!
    @IBOutlet weak var targetDisplay: UILabel!
    
    @IBOutlet weak var highestWeight: UILabel!
    @IBOutlet weak var lowestWeight: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    var weightArray = [Double]()
}
extension WeightViewController: UITextFieldDelegate{
    
    override func viewWillAppear(_ animated: Bool) {

        getUDToSetButton()
        getDBtoSetTitle()
        getHighestAndLowestToShow()
        showSurplusWeight()
//        print(weightArray)
    }
    func setupSubviews() {
        chartView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
               //設定位置 加入
               chartView = LineChartView()
               chartView.frame = CGRect(x: 20, y: 290, width: self.view.bounds.width - 30,
                                        height: 300)
               self.view.addSubview(chartView)
                
               //背景色
               chartView.backgroundColor = UIColor.white
                
               //沒有資料時
               chartView.noDataText = "無資料"
                
               //折線圖 文字及樣式
               
               chartView.chartDescription?.textColor = UIColor.red
                //取消網格線
                chartView.xAxis.drawGridLinesEnabled = false
               chartView.scaleYEnabled = false //取消Y轴缩放
               chartView.doubleTapToZoomEnabled = false //雙擊縮放
               chartView.dragEnabled = true //启用拖动手势
               chartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
               chartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
                chartView.rightAxis.enabled = false  //不繪製右邊軸
        chartView.leftAxis.gridAntialiasEnabled = true //抗鋸齒
        chartView.xAxis.spaceMin = 0.1 //設定間隔
        
               
        var dataEntries = [ChartDataEntry]()
        let array = getWeightArray()

        var idx = 1
        for i in array {
  //          let y = arc4random() % 150
            let entry = ChartDataEntry.init(x: Double(idx), y: Double(i))
            idx += 1
            dataEntries.append(entry)
            
        }
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: getDateStringArray())
        
               // 所有資料放進這一條
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "體重")
               //目前為一根折線
               let chartData = LineChartData(dataSets: [chartDataSet])
                
               //折線圖設定資料
               chartView.data = chartData
        //畫面最多顯示幾筆資料 x軸拖動
        chartView.setVisibleXRangeMaximum(3)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    @IBAction func addWeightHandler(_ sender: UIButton) {
        if let next = self.storyboard?.instantiateViewController(identifier: "addWeight") as AddWeightViewController? {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            next.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            present(next, animated: true, completion: nil)
        }
    }
    // 給使用者輸入目標體重，並儲存
    @IBAction func addTargetHandler(_ sender: UIButton) {
        if let next = self.storyboard?.instantiateViewController(identifier: "addTargetController") as? AddTargetController {
            next.modalPresentationStyle = .fullScreen
            next.modalTransitionStyle = .coverVertical
            next.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            present(next, animated: true, completion: nil)
        }
    }
    @IBAction func unwindToWeight(_ sender: UIStoryboardSegue) {
        getUDToSetButton()
        getDBtoSetTitle()
        getHighestAndLowestToShow()
        showSurplusWeight()
    }
    
    func getUDToSetButton() {
        let ud = UserDefaults.standard
        let targetWeight = ud.double(forKey: User_Target_Weight_Key)
            targetBtn.setTitle("目標:\(targetWeight)", for: .normal)
    }
    func getDBtoSetTitle() {
        let dao = NowWeightDAO.shared
        let data = dao.getLastData()
        if let lastWeight = data?.weight {
            navigationItem.title = "體重:\(lastWeight)"
        } else {
            navigationItem.title = "體重"
        }
    }
    func getHighestAndLowestToShow() {
        weightArray.removeAll()
        let dao = NowWeightDAO.shared
        let data = dao.getAllWeights()
        
        for obj in data {
            weightArray.append(obj.weight)
            }
        
        if let min = weightArray.min() {
            let minWeight = min
            lowestWeight.text = "\(minWeight)KG"
        }
        if let max = weightArray.max() {
            let maxWeight = max
            highestWeight.text = "\(maxWeight)KG"
        }
    }
    func showSurplusWeight() {
        let dao = NowWeightDAO.shared
        let data = dao.getLastData()
        if let nowWeight = data?.weight {
            let ud = UserDefaults.standard
            let targetWeight = ud.double(forKey: User_Target_Weight_Key)
            if nowWeight <= targetWeight {
                targetDisplay.text = "目標達成"
            } else {
                let result = nowWeight - targetWeight
                targetDisplay.text = "剩餘:\(String(format: "%.1f", result)) KG"
            }
        }
    }
    func getWeightArray() -> [Double] {
        weightArrayToShow.removeAll()
        let dao = NowWeightDAO.shared
        let data = dao.getAllWeights()
        for obj in data {
            weightArrayToShow.append(obj.weight)
        }
    return weightArrayToShow
    }
    func getDateStringArray() -> [String] {
        dateStrArray.removeAll()
        let dao = NowWeightDAO.shared
        let data = dao.getAllWeights()
        dateStrArray.append("0")
        for obj in data {
            let dateStr = String(obj.date)
            let startIndex = dateStr.index(dateStr.startIndex, offsetBy: 4)
            let endIndex =  dateStr.index(dateStr.startIndex, offsetBy: 8)
            let newStr = String(dateStr[startIndex..<endIndex])
            dateStrArray.append(newStr)
        }
        print(".........\(dateStrArray)")
        return dateStrArray
    }
}
