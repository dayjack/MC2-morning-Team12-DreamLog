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
    
    var db : OpaquePointer?
    private init() {}
    
    let databaseName = "mydb.sqlite"
    
    deinit {
        sqlite3_close(db)
    }
    
    
    func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        do {
            let dbPath: String = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(databaseName).path
            
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
    
    func createElementTable() {
        
        let query = """
CREATE TABLE IF NOT EXISTS Element (
  `index` INTEGER PRIMARY KEY AUTOINCREMENT,
  imagePosition_x float NOT NULL,
  imagePosition_y float NOT NULL,
  imageWidth INTEGER NOT NULL,
  imageHeight INTEGER NOT NULL,
  rotateDotPosition_x float NOT NULL,
  rotateDotPosition_y float NOT NULL,
  deleteDotPosition_x float NOT NULL,
  deleteDotPosition_y float NOT NULL,
  angle double NOT NULL,
  angleSum double NOT NULL,
  picture CHAR(255) NOT NULL
) ;
"""
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            // step은 쿼리를 실행하는 단계
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db : \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlite3_prepare failure while createing table: \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
    }
    
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
                print("Creating table has been succesfully done. db : \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlite3_prepare failure while createing table: \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
    }
    
    
    func insertElementData(imagePosition_x: CGFloat, imagePosition_y: CGFloat,
                           imageWidth: Int, imageHeight: Int,
                           rotateDotPosition_x: CGFloat, rotateDotPosition_y: CGFloat,
                           deleteDotPosition_x: CGFloat, deleteDotPosition_y: CGFloat, angle: Double, angleSum: Double, picture: Image, id : UUID) {
        // id 는 Auto increment 속성을 갖고 있기에 값을 대입해 줄 필요는 없지만 쿼리문에는 있어야함
        let insertQuery = """
        insert into Element (
        `index`,
        imagePosition_x, imagePosition_y,
        imageWidth, imageHeight,
        rotateDotPosition_x, rotateDotPosition_y,
        deleteDotPosition_x, deleteDotPosition_y,
        angle,
        angleSum,
        picture
        ) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_double(statement, 2, imagePosition_x)
            sqlite3_bind_double(statement, 3, imagePosition_y)
            sqlite3_bind_int(statement, 4, Int32(imageWidth))
            sqlite3_bind_int(statement, 5, Int32(imageHeight))
            sqlite3_bind_double(statement, 6, rotateDotPosition_x)
            sqlite3_bind_double(statement, 7, rotateDotPosition_y)
            sqlite3_bind_double(statement, 8, deleteDotPosition_x)
            sqlite3_bind_double(statement, 9, deleteDotPosition_y)
            sqlite3_bind_double(statement, 10, angle)
            sqlite3_bind_double(statement, 11, angleSum)
            // 이미지 처리
            
            
            
            do {
                // get the documents directory url
                let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                
                UserDefaults.standard.set(documentsDirectory, forKey: "dataPath")
                
                print("documentsDirectory:", documentsDirectory.path)
                // choose a name for your image
                let fileName = "\(id.uuidString).jpg"
                let image: Image = picture
                let uiImage: UIImage = image.asUIImage()
                
                // create the destination file url to save your image
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                // get your UIImage jpeg data representation and check if the destination file url already exists
                if let data = uiImage.jpegData(compressionQuality:  1),
                   !FileManager.default.fileExists(atPath: fileURL.path) {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                    sqlite3_bind_text(statement, 12, fileName, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                    
                    
                    
                    
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
                // get the documents directory url
                let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                
                UserDefaults.standard.set(documentsDirectory, forKey: "dataPath")
                
                print("documentsDirectory:", documentsDirectory.path)
                // choose a name for your image
                let fileName = "\(Date.now.description).jpg"
                //let image: Image = img
                let uiImage: UIImage = img
                
                // create the destination file url to save your image
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                // get your UIImage jpeg data representation and check if the destination file url already exists
                if let data = uiImage.jpegData(compressionQuality:  1),
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
    
    func readData() -> [BoardElement] {
        
        let query: String = "select * from Element;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [BoardElement] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let imagePosition_x = sqlite3_column_double(statement, 1)
            let imagePosition_y = sqlite3_column_double(statement, 2)
            let imageWidth = sqlite3_column_int(statement, 3)
            let imageHeight = sqlite3_column_int(statement, 4)
            let rotateDotPosition_x  = sqlite3_column_double(statement, 5)
            let rotateDotPosition_y  = sqlite3_column_double(statement, 6)
            let deleteDotPosition_x = sqlite3_column_double(statement, 7)
            let deleteDotPosition_y = sqlite3_column_double(statement, 8)
            let angle = sqlite3_column_double(statement, 9)
            let angleSum = sqlite3_column_double(statement, 10)
            
            print(sqlite3_column_text(statement, 11) ?? "못 불러옴")
            let filaname = String(cString: sqlite3_column_text(statement, 11))
            
            // 형변환을 해줘야함. Int의 경우 int32 형을 반환하기 때문
            result.append(BoardElement.init(imagePosition: .init(x: imagePosition_x, y: imagePosition_y), imageWidth: CGFloat(imageWidth), imageHeight: CGFloat(imageHeight), angle: .init(degrees: angle), angleSum: angleSum, picturePath: filaname, rotateDotPosition: .init(x: rotateDotPosition_x, y: rotateDotPosition_y), deleteDotPosition: .init(x: deleteDotPosition_x, y: deleteDotPosition_y)))
            
        }
        sqlite3_finalize(statement)
        print(result)
        return result
    }
    
    func readDreamLogData() -> [DreamLogModel] {
        
        let query: String = "select * from DreamLog;"
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
    
    
    // 값을 수정하기 전에 오류메시지가 계속 반복되니, 이를 해결하기 위한 함수
    private func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error preparing update: \(errorMessage)")
        return
    }
    
    
    func dropTable(tableName: String) {
        
        if tableName == "Element" {
            let nameArr = readImageNames()
            
            for name in nameArr {
                deleteImageByName(imgName: name)
            }
        }
        
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
    
    
    func readImageNames() -> [String] {
        
        let query: String = "select picture from Element;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [String] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let filaname = String(cString: sqlite3_column_text(statement, 0))
            
            result.append(filaname)
        }
        sqlite3_finalize(statement)
        return result
    }
    
    //id만 인자로 받아서 ID에 해당하는 레코드만 삭제하는 함수
    func deleteImageByName(imgName: String) {
        
        let fileManager = FileManager.default // 파일 매니저 선언
        let fileDirectoryPath =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first! // 애플리케이션 저장 폴더
        
        
        // [삭제를 수행할 파일 경로 지정]
        let fileDeletePath = fileDirectoryPath.absoluteString + imgName
        
        
        do {
            print("=====\(fileDeletePath)=====")
            
            try FileManager.default.removeItem(at: URL(string: fileDeletePath)!)
        } catch let e {
            print(e.localizedDescription)
        }
        
    }
    
}


