//
//  LearnTextDAO.swift
//  App
//
//  Created by 葉上輔 on 2020/7/23.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

class LearnTextDAO {
    var dbPath = ""
    private static var _inst = LearnTextDAO()
    public static var shared: LearnTextDAO {
        return _inst
    }
    private init() {
        dbPath = "\(NSHomeDirectory())/Documents/db.db"
        let fileMng = FileManager.default
        if !fileMng.fileExists(atPath: dbPath) {
            if let source = Bundle.main.path(forResource: "learnText", ofType: "db") {
               try? fileMng.copyItem(atPath: source, toPath: dbPath)
            }
        }
        print(dbPath)
    }
    func getAllTextById(fid: Int) -> LearnText? {
        var ret: LearnText?
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let result = db?.executeQuery("SELECT * FROM learnText WHERE title = ?", withArgumentsIn: [fid]) {
            if result.next() {
                let title = result.int(forColumn: "title")
                if let text = result.string(forColumn: "text") {
                  ret = LearnText(title: Int(title), text: text)
                }
                
            }
        }
        db?.close()
        return ret
    }
}
