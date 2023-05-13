//
//  CheerLogTableProtocol.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/13.
//

import Foundation
import SwiftUI

protocol CheerLogTableProtocol {
    
    func createCheerLogTable()
    func insertCheerLogData(_ cheer: String)
    func readCheerLogData() -> [CheerLogModel]
    func readCheerLogDataOne() -> CheerLogModel
    func deleteCheerLogData(id: Int)
}
