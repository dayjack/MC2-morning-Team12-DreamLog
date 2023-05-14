//
//  DBHelper.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/11.
//

import Foundation
import SQLite3
import SwiftUI

class DBHelper {
    
    static let shared = DBHelper()
    let databaseName = "mydb.sqlite"
    var db : OpaquePointer?
    
    private init() {}
    deinit { sqlite3_close(db) }
    
    func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        do {
            // MARK: - url 수정
            let dbPath: String = try FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")!.appendingPathComponent(databaseName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfullt create DB.path: \(dbPath)")
                self.db = db
                return db
            }
        } catch {
            print("Error while creating Database - \(error.localizedDescription)")
        }
        return nil
    }

    func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error preparing update: \(errorMessage)")
        return
    }
    
    func dropTable(tableName: String) {
        
        let queryString = "DROP TABLE \(tableName)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("drop table has been successfully done")
        
    }
}




