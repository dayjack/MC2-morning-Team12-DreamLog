//
//  CheerLogModel.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/13.
//

import Foundation

class CheerLogModel: Hashable, Equatable {
    
    static func == (lhs: CheerLogModel, rhs: CheerLogModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let shared = CheerLogModel()
    
    var id: Int
    var cheer: String
    var time: String
    
    private init() {
        self.id = -1
        self.cheer = ""
        self.time = ""
    }
    
    init(id: Int, cheer: String, time: String) {
        self.id = id
        self.cheer = cheer
        self.time = time
    }
    
}
