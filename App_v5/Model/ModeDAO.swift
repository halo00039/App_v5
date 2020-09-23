//
//  ModeDAO.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/7/30.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

class ModeDAO {
    var dbpath = ""
    private static var _inst = ModeDAO()
    public static var shared: ModeDAO {
        return _inst
    }
    private init() {
        dbpath = "\(NSHomeDirectory())/Documents/modedb_v3.db"
        let fileMng = FileManager.default
        if !fileMng.fileExists(atPath: dbpath) {
            if let src = Bundle.main.path(forResource: "mode", ofType: "db") {
            try? fileMng.copyItem(atPath: src, toPath: dbpath)
            }
        }
        print(dbpath)
    }
    
    func getAllMode() ->[Mode] {
        var list = [Mode]()
        let db = FMDatabase(path: dbpath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM mode", withArgumentsIn: []) {
            while result.next() {
                let mid = result.int(forColumn: "mid")
                let mode = result.int(forColumn: "mode")
                let data = Mode(mid: Int(mid), mode: Int(mode))
                list.append(data)
            }
            result.close()
        }
        
        db?.close()
        return list
    }
    
    func getModeById(_ mid: Int) -> Mode? {
        var ret: Mode?
        let db = FMDatabase(path: dbpath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM mode WHERE mid = ?", withArgumentsIn: [mid]) {
            if result.next() {
                let mid = result.int(forColumn: "mid")
                let mode = result.int(forColumn: "mode")
                ret = Mode(mid: Int(mid), mode: Int(mode))
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
    func insert(data: Mode) {
        var dict = [String : Any]()
        dict["m"] = data.mode
        let sql = "INSERT INTO mode (mode) VALUES(:m)"
        generalUpdateFunction(sql: sql,params: dict)
    }
    
    func delete(mid: Int){
        var dict = [String:Any]()
        dict["mid"] = mid
        let sql = "DELETE FROM mode WHERE mid = :mid"
        generalUpdateFunction(sql: sql, params: dict)
    }
}
