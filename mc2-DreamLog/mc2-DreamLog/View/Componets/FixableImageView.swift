//
//  FixableImageView.swift
//  mc2-DreamLog
//
//  Created by Leejaehyuk on 2023/05/08.
//

import SwiftUI

struct FixableImageView: View {
    @EnvironmentObject var thisElement: BoardElement
    @EnvironmentObject var environmentElementList: TutorialBoardElement
    @EnvironmentObject var FUUID: FocusUUID
    // 이미지 위치 이동을 위한 상태변수들
    
    @GestureState var startLocation: CGPoint? = nil
    
    
    var body: some View {
        ZStack{
            thisElement.picture
                .resizable()
                .scaledToFit()
                .frame(width: thisElement.imageWidth, height: thisElement.imageHeight)
//                .border(FUUID.focusUUID == thisElement.id ? .black : .clear)
                .overlay {
                    
                    if FUUID.focusUUID == thisElement.id {
                        Rectangle()
//                          .foregroundColor(.gray)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [10]))
                    }
                        
                }.foregroundColor(.gray.opacity(0.5))
                .zIndex(Double(environmentElementList.findIndex(one: thisElement.id)))
                .rotationEffect(thisElement.angle)
                .position(x: thisElement.imagePosition.x, y: thisElement.imagePosition.y)
                
                .gesture(
                    FUUID.focusUUID == thisElement.id ? moveDrag : nil
                )
                .onTapGesture {
                    FUUID.focusUUID = thisElement.id
                    
                    let tempElement = environmentElementList.findOne(one: thisElement.id)
                    environmentElementList.removeOne(one: thisElement.id)
                    environmentElementList.viewArr.append(tempElement)
                    
                    
                }
//                .onLongPressGesture(perform: {
//                    if FUUID.focusUUID == thisElement.id {
//                        let tempElement = environmentElementList.findOne(one: thisElement.id)
//                        environmentElementList.removeOne(one: thisElement.id)
//                        environmentElementList.viewArr.append(tempElement)
//                    }
//                })
            
            if FUUID.focusUUID == thisElement.id {
                Image(systemName: "x.circle.fill")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .position(x: thisElement.deleteDotPosition.x, y: thisElement.deleteDotPosition.y)
                    .zIndex(Double(environmentElementList.findIndex(one: thisElement.id))+1)
                    .onTapGesture {
                        environmentElementList.removeOne(one: thisElement.id)
                    }
                
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .position(x: thisElement.rotateDotPosition.x, y: thisElement.rotateDotPosition.y)
                    .zIndex(Double(environmentElementList.findIndex(one: thisElement.id))+1)
                    .gesture(
                        resizeAndRotateDrag
                    )
            }
        }
    }
    
    var resizeAndRotateDrag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                print(environmentElementList.viewArr.count)
                var centerToNewPositionDistance = sqrt(pow(gesture.location.x - thisElement.imagePosition.x, 2) + pow(gesture.location.y - thisElement.imagePosition.y, 2))
                var imageDiagonal = sqrt(pow(thisElement.imageWidth,2) + pow(thisElement.imageHeight,2))
                
                let newImageWidth = centerToNewPositionDistance * 2 * thisElement.imageWidth / imageDiagonal
                let newImageHeight = centerToNewPositionDistance * 2 * thisElement.imageHeight / imageDiagonal
                
                thisElement.imageWidth = newImageWidth
                thisElement.imageHeight = newImageHeight
                
                imageDiagonal = sqrt(pow(thisElement.imageWidth,2) + pow(thisElement.imageHeight,2))
                centerToNewPositionDistance = sqrt(pow(gesture.location.x - thisElement.imagePosition.x, 2) + pow(gesture.location.y - thisElement.imagePosition.y, 2))
                
                let originalAngle = atan2(thisElement.rotateDotPosition.y - thisElement.imagePosition.y, thisElement.rotateDotPosition.x - thisElement.imagePosition.x)
                let newAngle = atan2(gesture.location.y - thisElement.imagePosition.y, gesture.location.x - thisElement.imagePosition.x)
                
                thisElement.angleSum += (-(originalAngle - newAngle) * 180 / CGFloat.pi)
                thisElement.angle = .degrees(thisElement.angleSum)
                
                
                thisElement.rotateDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.rotateDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.y
                
                thisElement.deleteDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.deleteDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.y
            }
    }
    
    var moveDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? thisElement.imagePosition
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                thisElement.imagePosition = newLocation
                
                thisElement.rotateDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.rotateDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.y
                
                thisElement.deleteDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.deleteDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.y
                
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? thisElement.imagePosition
                
                thisElement.rotateDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.rotateDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageHeight/2) + thisElement.imagePosition.y
                
                thisElement.deleteDotPosition.x = cos(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) - sin(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.x
                thisElement.deleteDotPosition.y = sin(thisElement.angleSum / 180 * Double.pi) * (thisElement.imageWidth/2) + cos(thisElement.angleSum / 180 * Double.pi) * (-thisElement.imageHeight/2) + thisElement.imagePosition.y
                
            }
    }
    
    
}

struct FixableImageView_Previews: PreviewProvider {
    static var previews: some View {
        FixableImageView()
    }
}
