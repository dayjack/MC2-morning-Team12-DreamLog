//
//  EditDrawingView.swift
//  mc2-DreamLog
//
//  Created by Park Jisoo on 2023/05/04.
//
import SwiftUI
import PencilKit


struct EditDrawingView: View {
    
    @State var colorArr: [Color] = [
        .black,
        .red,
        .orange,
        .brown,
        .yellow,
        .green,
        .blue,
        .indigo,
        .purple,
        .pink,
        .cyan,
        .mint,
    ]
    
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
    
    var body: some View{
        BgColorGeoView{ geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            VStack{
                
                HStack{
                    Button{
                        // cancel drawring

                        
                    }label: {
                        Text("cancel")
                            .foregroundColor(.textGreen)
                            .font(.system(size: 22))
                    }.padding(.leading, 25)
                    
                    Spacer()
                    
                    Button{
                      // save drawing
                        
                        
                    }label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.textGreen)
                            .font(.system(size: 22))
                    }
                    .padding(.trailing, 25)
                }
                
                // Drawing Canvas
                DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $colorArr[colorNum], width: $sliderValue)
                
                // pen mode
                if isDraw{
                    EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw)
                }
                // eraser mode
                else{
                    EditDrawingMenuView(sliderValue: $sliderValue, colorNum: $colorNum, colorArr: $colorArr, isDraw: $isDraw)
                    
                }
                
                // EditDrawingMenu
                HStack {
                    Button {
                        if isDraw {}
                        else{
                            isDraw.toggle()
                        }
                        
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
            PKInkingTool(type, color: UIColor(color), width: width)
        }
        
        
        let eraser = PKEraserTool(.bitmap)
        
        
        func makeUIView(context: Context) -> PKCanvasView {
            canvas.drawingPolicy = .anyInput
            
            canvas.tool = isDraw ? ink : eraser
            
            return canvas
        }
        
        func updateUIView(_ uiView: PKCanvasView, context: Context) {
            
            uiView.tool = isDraw ? ink : eraser
        }
        
//        이미지로 바꾸고 싶은데 잘 되지 않음.
//        func saveCanvasAsUIImage(canvasView: PKCanvasView) -> UIImage {
//            let renderer = UIGraphicsImageRenderer(bounds: canvasView.bounds)
//            return renderer.image { rendererContext in
//                canvasView.layer.render(in: rendererContext.cgContext)
//            }
//        }
//
//
//        func captureImage() -> UIImage {
//            let uiImage = saveCanvasAsUIImage(canvasView: canvas)
//            return uiImage
        }
    }


struct EditDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            EditDrawingView()
        }
    }
}
