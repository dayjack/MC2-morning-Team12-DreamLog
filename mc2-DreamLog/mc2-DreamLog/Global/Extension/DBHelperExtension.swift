//
//  DBHelperExtension.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/13.
//

import SwiftUI
import SQLite3

extension DBHelper: DreamLogTableProtocol {
    
    func createDreamLogTable() {
        
        let query = """
        CREATE TABLE IF NOT EXISTS DreamLog (
          `id` INTEGER PRIMARY KEY AUTOINCREMENT,
          `picture` CHAR(255) NOT NULL,
          `time` timestamp NOT NULL default current_timestamp
        ) ;
        """
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            // step은 쿼리를 실행하는 단계
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating Dream Log table has been succesfully done. db : \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlite3_prepare failure while createing table: \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
    }
    func insertDreamLogData(img: UIImage) {
        // id 는 Auto increment 속성을 갖고 있기에 값을 대입해 줄 필요는 없지만 쿼리문에는 있어야함
        let insertQuery = """
            insert into DreamLog (
            `id`,
            picture
            ) values (?, ?);
            """
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            
            // 이미지 처리
            do {
                // MARK: - url 수정
                let documentsDirectory = try FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")!
                
                UserDefaults.standard.set(documentsDirectory, forKey: "dataPath")
                
                print("documentsDirectory:", documentsDirectory.path)
                // choose a name for your image
                let fileName = "\(Date.now.description).png"
                //let image: Image = img
                let uiImage: UIImage = img
                
                // create the destination file url to save your image
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                // get your UIImage jpeg data representation and check if the destination file url already exists
                // MARK: - url 수정
                if let data = uiImage.pngData(),
                   !FileManager.default.fileExists(atPath: fileURL.path) {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                    sqlite3_bind_text(statement, 2, fileName, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                }
            } catch {
                print("error:", error)
            }
        }
        else {
            print("sqlite binding failure")
        }
        // step은 쿼리를 실행하는 단계
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func readDreamLogData() -> [DreamLogModel] {
        
        let query: String = "select * from DreamLog ORDER BY id DESC;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [DreamLogModel] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int(statement, 0)
            
            let path = String(cString: sqlite3_column_text(statement, 1))
            let time = String(cString: sqlite3_column_text(statement, 2))
            
            // 형변환을 해줘야함. Int의 경우 int32 형을 반환하기 때문
            result.append(.init(id: Int(id), imagePath: path, time: time))
            
        }
        sqlite3_finalize(statement)
        print(result)
        return result
    }
    
    func readDreamLogDataOne() -> DreamLogModel {
        
        let query: String = "SELECT * FROM DreamLog ORDER BY id DESC LIMIT 1;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: DreamLogModel = .init(id: -1, imagePath: "", time: "")
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int(statement, 0)
            
            let path = String(cString: sqlite3_column_text(statement, 1))
            let time = String(cString: sqlite3_column_text(statement, 2))
            
            // 형변환을 해줘야함. Int의 경우 int32 형을 반환하기 때문
            result = .init(id: Int(id), imagePath: path, time: time)
        }
        sqlite3_finalize(statement)
        print(result)
        return result
    }
    
    
    func deleteDreamLogData(id: Int) {
        let queryString = "DELETE from DreamLog where id == \(id)"
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
    
    //id만 인자로 받아서 ID에 해당하는 레코드만 삭제하는 함수
    func deleteImageByName(imgName: String) {
        // MARK: - url 수정
        let fileManager = FileManager.default // 파일 매니저 선언
        let fileDirectoryPath =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")! // 애플리케이션 저장 폴더
        
        // [삭제를 수행할 파일 경로 지정]
        let fileDeletePath = fileDirectoryPath.absoluteString + imgName
        
        do {
            print("=====\(fileDeletePath)=====")
            // MARK: - url 수정
            try FileManager.default.removeItem(at: URL(string: fileDeletePath)!)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func deleteAllDreamLog() {
        let queryString = "DELETE from DreamLog"
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


extension DBHelper: CheerLogTableProtocol {
    
    func createCheerLogTable() {
        
        let query = """
        CREATE TABLE IF NOT EXISTS CheerLog (
          `id` INTEGER PRIMARY KEY AUTOINCREMENT,
          `cheer` CHAR(255) NOT NULL,
        `time` timestamp NOT NULL default current_timestamp
        );
        """
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            // step은 쿼리를 실행하는 단계
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating CheerLog table has been succesfully done. db : \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlite3_prepare failure while createing table: \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
        
        
    }
    
    func insertCheerLogData(_ cheer: String) {
        // id 는 Auto increment 속성을 갖고 있기에 값을 대입해 줄 필요는 없지만 쿼리문에는 있어야함
        let insertQuery = """
        insert into CheerLog (
        `id`,
        cheer
        ) values (?, ?);
        """
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 2, cheer, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
        }
        else {
            print("sqlite binding failure")
        }
        // step은 쿼리를 실행하는 단계
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func readCheerLogData() -> [CheerLogModel] {
        let query: String = "SELECT * FROM CheerLog ORDER BY id DESC;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [CheerLogModel] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let cheer = String(cString: sqlite3_column_text(statement, 1))
            let time = String(cString: sqlite3_column_text(statement, 2))
            
            result.append(.init(id: Int(id), cheer: cheer, time: time))
        }
        sqlite3_finalize(statement)
        print("result - readCheerLogData: \(result)")
        return result
    }
    
    func readCheerLogDataOne() -> CheerLogModel {
        let query: String = "SELECT * FROM CheerLog ORDER BY id DESC LIMIT 1;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: CheerLogModel = .init(id: -1, cheer: "", time: "")
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int(statement, 0)
            
            let cheer = String(cString: sqlite3_column_text(statement, 1))
            let time = String(cString: sqlite3_column_text(statement, 2))
            
            // 형변환을 해줘야함. Int의 경우 int32 형을 반환하기 때문
            result = .init(id: Int(id), cheer: cheer, time: time)
        }
        sqlite3_finalize(statement)
        print(result)
        return result
    }
    
    func deleteCheerLogData(id: Int) {
        let queryString = "DELETE from CheerLog where id == \(id)"
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

