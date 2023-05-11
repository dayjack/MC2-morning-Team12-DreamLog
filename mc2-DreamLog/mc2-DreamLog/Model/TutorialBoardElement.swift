//
//  TutorialBoardElement.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

class TutorialBoardElement : ObservableObject {
    
    @Published var viewArr: [BoardElement] = []
    var TutorialBoardWidthCenter: CGFloat = 0
    var TutorialBoardHeightCenter: CGFloat = 0
    
    func findOne(one: UUID) -> BoardElement {
        for index in 0...viewArr.count-1 {
            if(viewArr[index].id == one){
                return viewArr[index]
            }
        }
        //쓰레기 리턴
        return BoardElement(imagePosition: CGPoint(x:0, y:0), imageWidth: 0, imageHeight: 0, angle: .degrees(0), angleSum: 0, picture: Image("emoji"))
    }
    
    func findIndex(one: UUID) -> Int {
        for index in 0..<viewArr.count {
            if(viewArr[index].id == one){
                return index
            }
        }
        return -1
    }
    
    func removeOne(one: UUID) -> () {
        for index in 0...viewArr.count-1 {
            if(viewArr[index].id == one){
                viewArr.remove(at: index)
                break
            }
        }
    }
    
}
