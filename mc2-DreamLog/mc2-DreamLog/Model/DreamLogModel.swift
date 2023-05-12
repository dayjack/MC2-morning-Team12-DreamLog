//
//  DreamLogModel.swift
//  mc2-DreamLog
//
//  Created by Leejaehyuk on 2023/05/12.
//

import Foundation

class DreamLogModel {
    
    static let shared = DreamLogModel()
    
    var id: Int
    var imagePath: String
    var time: String
    
    init(id: Int, imagePath: String, time: String) {
        self.id = id
        self.imagePath = imagePath
        self.time = time
    }
    
    init() {
        id = -1
        imagePath = ""
        time = ""
    }
    
}
