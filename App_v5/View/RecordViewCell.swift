//
//  RecordViewCell.swift
//  App
//
//  Created by 葉上輔 on 2020/7/27.
//  Copyright © 2020 YehSF. All rights reserved.
//
import Charts
import UIKit
import SwiftUI
class RecordViewCell: UITableViewCell {
    var hoursArray = [Int]()
    var dateArray = [String]()
    var delegateR: RecordViewController?
    static let identifier = "RecordViewCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "RecordViewCell", bundle: nil)
    }
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var recordDisplay: UIView!
    var barChart = BarChartView()
//    let daysArray = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]
    override func awakeFromNib() {
        super.awakeFromNib()
        barChart.frame = CGRect(x: 0, y: 0, width: recordView.frame.size.width , height: recordView.frame.size.width )
        barChart.center = CGPoint(x: recordView.center.x, y: recordView.center.y + 30)
        recordView.addSubview(barChart)
        
        barChart.noDataText = "無資料"
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.dragEnabled = true
        barChart.rightAxis.enabled = false
        barChart.xAxis.labelPosition = .bottom
  //      barChart.xAxis.spaceMin = 0.0
        var entries = [BarChartDataEntry]()
        var idx = 0
        for x in getHoursDataFromDB() {
            entries.append(BarChartDataEntry(x: Double(idx), y: Double(x)))
            idx += 1
        }
        print(getAllDataFromDB())
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: getAllDataFromDB())
        let set = BarChartDataSet(entries: entries, label: "時數")
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        barChart.setVisibleXRangeMaximum(3)
        delegateR?.tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func upDateDataToShow() {
        barChart.frame = CGRect(x: 0, y: 0, width: recordView.frame.size.width , height: recordView.frame.size.width )
              barChart.center = CGPoint(x: recordView.center.x, y: recordView.center.y + 30)
              recordView.addSubview(barChart)
              
              barChart.noDataText = "無資料"
              barChart.xAxis.drawGridLinesEnabled = false
              barChart.doubleTapToZoomEnabled = false
              barChart.dragEnabled = true
              barChart.rightAxis.enabled = false
              barChart.xAxis.labelPosition = .bottom
        //      barChart.xAxis.spaceMin = 0.0
              var entries = [BarChartDataEntry]()
              var idx = 0
              for x in getHoursDataFromDB() {
                  entries.append(BarChartDataEntry(x: Double(idx), y: Double(x)))
                  idx += 1
              }
              print(getAllDataFromDB())
              barChart.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: getAllDataFromDB())
              let set = BarChartDataSet(entries: entries, label: "時數")
              set.colors = ChartColorTemplates.joyful()
              
              let data = BarChartData(dataSet: set)
              barChart.data = data
              
              barChart.setVisibleXRangeMaximum(3)
    }
    func getHoursDataFromDB() -> [Int] {
        hoursArray.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
        for obj in data {
            hoursArray.append(obj.hours)
        }
        return hoursArray
    }
    func getAllDataFromDB() -> [String] {
        dateArray.removeAll()
        let dao = FastingListDAO.shared
        let data = dao.getAllTime()
    
        for obj in data {
            let str = obj.date
            let startIndex = str.index(str.startIndex, offsetBy: 5)
            let endIndex =  str.index(str.startIndex, offsetBy: 10)
            let newStr = String(str[startIndex..<endIndex])
           
            dateArray.append(newStr)
            print(newStr)
        }
        print("array...\(dateArray)")
        return dateArray
    }
    
}

