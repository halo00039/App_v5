//
//  NowWeightDAO.swift
//  App
//
//  Created by 葉上輔 on 2020/7/28.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

class NowWeightDAO {
    var dbpath = ""
    private static var _init = NowWeightDAO()
    public static var shared: NowWeightDAO {
        return _init
    }
    private init() {
        dbpath = "\(NSHomeDirectory())/Documents/weightdb_v6.db"
        let fileMng = FileManager.default
        if !fileMng.fileExists(atPath: dbpath) {
            if let src = Bundle.main.path(forResource: "NowWeight", ofType: "db") {
               try? fileMng.copyItem(atPath: src, toPath: dbpath)
            }
        }
        print(dbpath)
    }
    
    func getAllWeights() -> [NowWeight] {
        var list = [NowWeight]()
        let db = FMDatabase(path: dbpath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM NowWeight", withArgumentsIn: []) {
            while result.next() {
                let wid = result.int(forColumn: "wid")
                let date = result.int(forColumn: "date")
                let weight = result.double(forColumn: "weight")
                let data = NowWeight(wid: Int(wid), date: Int(date), weight: weight)
                list.append(data)
            }
            result.close()
        }
        db?.close()
        return list
    }
    
    func getWeightById(_ wid: Int) -> NowWeight? {
        var ret: NowWeight?
        let db = FMDatabase(path: dbpath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM NowWeight WHERE wid = ?", withArgumentsIn: [wid]) {
            if result.next() {
            let wid = result.int(forColumn: "wid")
            let date = result.int(forColumn: "date")
            let weight = result.double(forColumn: "weight")
                ret = NowWeight(wid: Int(wid), date: Int(date), weight: weight)
            }
            result.close()
        }
        db?.close()
        return ret
    }
    
    func getLastData() -> NowWeight? {
        var ret: NowWeight?
        let db = FMDatabase(path: dbpath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM NowWeight  ORDER BY wid DESC LIMIT 0 , 1", withArgumentsIn: []) {
            if result.next() {
                let wid = result.int(forColumn: "wid")
                let date = result.int(forColumn: "date")
                let weight = result.double(forColumn: "weight")
                ret = NowWeight(wid: Int(wid), date: Int(date), weight: weight)
            }
            result.close()
        }
        db?.close()
        return ret
    }
    
    
    func generalUpdateFunction(sql: String, params: [String:Any]) {
        let db = FMDatabase(path: dbpath)
        db?.open()
        db?.executeUpdate(sql, withParameterDictionary: params)
        db?.close()
    }
    
    func insert(data: NowWeight) {
        var dict = [String:Any]()
//        dict["w"] = data.wid
        dict["d"] = data.date
        dict["g"] = data.weight
        let sql = "INSERT INTO NowWeight (date,weight) VALUES(:d,:g)"
        generalUpdateFunction(sql: sql, params: dict)
    }
    
}
