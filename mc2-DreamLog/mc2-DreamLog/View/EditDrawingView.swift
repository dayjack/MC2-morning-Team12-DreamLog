//
//  EditDrawingView.swift
//  mc2-DreamLog
//
//  Created by Park Jisoo on 2023/05/04.
//
import SwiftUI
import PencilKit

struct EditDrawingView: View {
    
    @State var colorArr: [Color] = ColorPreset.colorPallete
    
    @State var btnNames: [String] = [
        "paintbrush.pointed",
        "pencil",
        "highlighter",
        "eraser",
        "arrow.uturn.backward",
        "arrow.uturn.forward"
    ]
    
    @State var buttonDictionary: [String : penType] = [
        "paintbrush.pointed" : .pen,
        "pencil" : .pencil,
        "highlighter" : .marker,
        "eraser" : .eraser,
        "arrow.uturn.backward" : .undo,
        "arrow.uturn.forward" : .redo
    ]
    
    enum penType {
        case pen
        case pencil
        case marker
        case eraser
        case undo
        case redo
    }
    
    @State var sliderValue = 1.0
    @State var colorNum = 0
    @State var color : Color = .black
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var curPenType = penType.pen
    @State var type : PKInkingTool.InkType = .pen
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var data: TutorialBoardElement
    @EnvironmentObject var FUUID: FocusUUID
    
    var body: some View{
        BgColorGeoView{ geo in
            VStack{
                HStack{
                    Button{
                        // cancel drawring
                        dismiss()
                    }label: {
                        Text("cancel")
                            .foregroundColor(.textGreen)
                            .font(.system(size: 22))
                    }.padding(.leading, 25)
                    
                    Spacer()
                    
                    Button{
                        // save drawing
                        let capturedImage = DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $colorArr[colorNum], width: $sliderValue).captureImage()
                        data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:data.TutorialBoardWidthCenter , y: data.TutorialBoardHeightCenter), imageWidth: (capturedImage.size.width > capturedImage.size.height) ?  200 : (capturedImage.size.width / capturedImage.size.height * 200), imageHeight: (capturedImage.size.width > capturedImage.size.height) ? (capturedImage.size.height / capturedImage.size.width * 200) : 200, angle: .degrees(0), angleSum: 0, picture: Image(uiImage: capturedImage)))
                        FUUID.focusUUID = data.viewArr.last!.id
                        dismiss()
                        
                    }label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.textGreen)
                            .font(.system(size: 22))
                    }
                    .padding(.trailing, 25)
                }
                
                // Drawing Canvas
                DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $colorArr[colorNum], width: $sliderValue)
                
                // show color preset? == pen mode or eraser mode ?
                isDraw ? EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw) :  EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw)
                
                // EditDrawingMenu
                HStack {
                    ForEach(0..<btnNames.count, id: \.self){ index in
                        Button{
                            switch index {
                            case 0:
                                curPenType = buttonDictionary[btnNames[index]]!
                                type = .pen
                                isDraw = true
                            case 1:
                                curPenType = buttonDictionary[btnNames[index]]!
                                type = .pencil
                                isDraw = true
                            case 2:
                                curPenType = buttonDictionary[btnNames[index]]!
                                type = .marker
                                isDraw = true
                            case 3:
                                curPenType = buttonDictionary[btnNames[index]]!
                                isDraw = false
                            case 4:
                                curPenType = curPenType
                                let undoManager = canvas.undoManager
                                undoManager?.undo()
                            case 5:
                                curPenType = curPenType
                                let undoManager = canvas.undoManager
                                undoManager?.redo()
                            default :
                                print("there is no button")
                            }
                        } label: {
                            Image(systemName: btnNames[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                                .menuButton()
                                .foregroundColor(
                                    curPenType == buttonDictionary[btnNames[index]] ? .textGreen : .textGray)
                        }
                    }
                }
            }
        }
    }
    
    
    struct DrawingView: UIViewRepresentable{
        
        @Binding var canvas : PKCanvasView
        @Binding var isDraw : Bool
        @Binding var type : PKInkingTool.InkType
        @Binding var color : Color
        @Binding var width : Double
        
        var ink : PKInkingTool{
            PKInkingTool(type, color: UIColor(color), width: width)}
        
        let eraser = PKEraserTool(.bitmap)
        
        func makeUIView(context: Context) -> PKCanvasView {
            canvas.drawingPolicy = .anyInput
            canvas.tool = isDraw ? ink : eraser
            return canvas}
        
        func updateUIView(_ uiView: PKCanvasView, context: Context) {
            uiView.tool = isDraw ? ink : eraser}
        
        func saveCanvasAsUIImage(canvasView: PKCanvasView) -> UIImage {
            return canvasView.drawing.image(from: CGRect(x: canvasView.drawing.bounds.minX, y: canvasView.drawing.bounds.minY, width: canvasView.drawing.bounds.maxX - canvasView.drawing.bounds.minX, height: canvasView.drawing.bounds.maxY - canvasView.drawing.bounds.minY), scale: 1.0)}
        
        func captureImage() -> UIImage {
            let uiImage = saveCanvasAsUIImage(canvasView: canvas)
            return uiImage}
    }
}


struct EditDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            EditDrawingView()
        }
    }
}
