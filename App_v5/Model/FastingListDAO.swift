//
//  FastingListDAO.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/8/4.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

class FastingListDAO {
    var dbPath = ""
    private static var _inst = FastingListDAO()
    public static var shared: FastingListDAO {
        return _inst
    }
    private init() {
        dbPath = "\(NSHomeDirectory())/Documents/ftdb_v5.db"
        let fileMng = FileManager.default
        if !fileMng.fileExists(atPath: dbPath) {
            if let src = Bundle.main.path(forResource: "FastingList", ofType: "db") {
                try? fileMng.copyItem(atPath: src, toPath: dbPath)
            }
        }
        print(dbPath)
    }
    
    func getAllTime() -> [FastingList] {
        var list = [FastingList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM FastingList", withArgumentsIn: []) {
            while result.next() {
                let fid = result.int(forColumn: "fid")
                let hours = result.int(forColumn: "hours")
                let bool = result.int(forColumn: "bool")
                if let date = result.string(forColumn: "date"), let mark = result.string(forColumn: "mark") {
                    let data = FastingList(fid: Int(fid), date: date, hours: Int(hours), mark: mark, bool: Int(bool))
                    list.append(data)
                }
                
            }
            result.close()
        }
        
        db?.close()
        return list
    }
        func getLastData() -> FastingList? {
        var ret: FastingList?
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM FastingList  ORDER BY fid DESC LIMIT 0 , 1", withArgumentsIn: []) {
            if result.next() {
                let fid = result.int(forColumn: "fid")
                let hours = result.int(forColumn: "hours")
                let bool = result.int(forColumn: "bool")
                if let date = result.string(forColumn: "date"), let mark = result.string(forColumn: "mark") {
                    ret = FastingList(fid: Int(fid), date: date, hours: Int(hours), mark: mark, bool: Int(bool))
                }
            }
            result.close()
        }
        db?.close()
        return ret
    }
        func getContactsByName(text : String) -> [FastingList] {
            var list = [FastingList]()
            let db = FMDatabase(path: dbPath)
            db?.open()

            if let result = db?.executeQuery("SELECT * FROM FastingList WHERE date like ?", withArgumentsIn: ["%\(text)%"]) {
                while result.next() {
                    let fid = result.int(forColumn: "fid")
                    let hours = result.int(forColumn: "hours")
                    let bool = result.int(forColumn: "bool")
                    if let date = result.string(forColumn: "date"), let mark = result.string(forColumn: "mark") {
                        let data = FastingList(fid: Int(fid), date: date, hours: Int(hours), mark: mark, bool: Int(bool))
                        list.append(data)}
                }
                result.close()
            }
            db?.close()
            return list
        }
    func generalUpdateFunction(sql: String, params: [String:Any]) {
        let db = FMDatabase(path: dbPath)
        db?.open()
        db?.executeUpdate(sql, withParameterDictionary: params)
        db?.close()
    }
    func insert(data: FastingList) {
        var dict = [String:Any]()
         dict["d"] = data.date
         dict["h"] = data.hours
         dict["m"] = data.mark
         dict["b"] = data.bool
        let sql = "INSERT INTO FastingList (date,hours,mark,bool) VALUES(:d,:h,:m,:b)"
        generalUpdateFunction(sql: sql, params: dict)
    }
    func update(data: FastingList){
        var dict = [String:Any]()
        dict["d"] = data.date
        dict["h"] = data.hours
        dict["m"] = data.mark
        dict["b"] = data.bool
        let sql = "UPDATE FastingList SET date=:d, hours=:h, mark=:m, bool=:b WHERE fid = :fid"
        generalUpdateFunction(sql: sql, params: dict)
    }
    
}
