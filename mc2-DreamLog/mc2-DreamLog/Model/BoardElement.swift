//
//  BoardElement.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

class BoardElement: Identifiable, Hashable, ObservableObject {
    
    let id = UUID()
    
    @Published var imagePosition = CGPoint(x: 0, y: 0)
    @Published var imageWidth:CGFloat = 0
    @Published var imageHeight:CGFloat = 0
   
    @Published var rotateDotPosition: CGPoint = .init(x: 0, y:0)
    @Published var deleteDotPosition: CGPoint = .init(x: 0, y: 0)
    
    @Published var angle: Angle = .degrees(0)
    @Published var angleSum:Double = 0
    
//    imageHeight / imageWidth * 100 <- 고정값으로줄
    
    var picture: Image
    
    init(imagePosition: CGPoint, imageWidth: CGFloat, imageHeight: CGFloat, angle: Angle, angleSum: Double, picture: Image) {
        self.imagePosition = imagePosition
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.rotateDotPosition = CGPoint(x: imagePosition.x + imageWidth/2, y: imagePosition.y + imageHeight/2)
        self.deleteDotPosition = CGPoint(x: imagePosition.x + imageWidth/2, y: imagePosition.y - imageHeight/2)
        self.angle = angle
        self.angleSum = angleSum
        self.picture = picture
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BoardElement, rhs: BoardElement) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
}
