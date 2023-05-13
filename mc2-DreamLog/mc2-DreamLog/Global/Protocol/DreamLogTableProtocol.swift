//
//  DreamLogTableProtocol.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/13.
//

import SwiftUI

protocol DreamLogTableProtocol {
    
    func createDreamLogTable()
    func insertDreamLogData(img: UIImage)
    func readDreamLogData() -> [DreamLogModel]
    func readDreamLogDataOne() -> DreamLogModel
    func deleteDreamLogData(id: Int)
    func deleteImageByName(imgName: String)
}
