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
        "pencil",
        "eraser"
    ]
    
    @State var sliderValue = 1.0
    @State var colorNum = 0
    @State var color : Color = .black
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var type : PKInkingTool.InkType = .pen
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var data: TutorialBoardElement
    
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
                        data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 2), imageWidth: (capturedImage.size.width > capturedImage.size.height) ?  200 : (capturedImage.size.width / capturedImage.size.height * 200), imageHeight: (capturedImage.size.width > capturedImage.size.height) ? (capturedImage.size.height / capturedImage.size.width * 200) : 200, angle: .degrees(0), angleSum: 0, picture: Image(uiImage: capturedImage)))
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
                
                // pen mode ? or eraser mode ?
                isDraw ? EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw) :  EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw)
                
                // EditDrawingMenu
                HStack {
                    // Select Pen
                    Button {
                        if isDraw {}
                        else{ isDraw.toggle()}
                        
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(isDraw ?  .textGreen : .secondary)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
                    // Select Eraser
                    Button {
                        if isDraw { isDraw.toggle()}
                        else{}
                        
                    } label: {
                        Image(systemName: "eraser")
                            .foregroundColor(isDraw ? .secondary : .textGreen)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom, 20)
                    Spacer()
                    
                    // remove All
                    Button {
                        canvas.drawing.strokes.removeAll()
                    } label: {
                        Image(systemName: "eraser")
                            .foregroundColor(isDraw ? .secondary : .textGreen)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom, 20)
                    
                    // Undo
                    Button {
                        var undoManager = canvas.undoManager
                        undoManager?.undo()
                    } label: {
                        Image(systemName: "eraser")
                            .foregroundColor(isDraw ? .secondary : .textGreen)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom, 20)
                    
                    // Redo
                    Button {
                        var undoManager = canvas.undoManager
                        undoManager?.redo()
                    } label: {
                        Image(systemName: "eraser")
                            .foregroundColor(isDraw ? .secondary : .textGreen)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.bottom, 20)
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
