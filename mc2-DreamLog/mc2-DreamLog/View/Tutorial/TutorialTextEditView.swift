//
//  TutorialTextEditView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/07.
//

import SwiftUI

struct FontName : Hashable {
    var korName: String
    var engName: String
}

struct TutorialTextEditView: View {
    
    @Environment(\.displayScale) var displayScale
    
    let fontList = ["JalnanOTF", "Pilseung Gothic Regular"]
    let fontArr: [FontName] = [
        FontName(
            korName: "필승 고딕",
            engName: "Pilseung Gothic Regular"),
        FontName(
            korName: "여기어때",
            engName: "JalnanOTF"),
    ]
    
    let colorArr: [Color] = [
        .blue,
        .purple,
        .brown,
        .cyan,
        .green,
        .indigo,
        .mint,
        .orange,
        .pink,
        .blue,
        .purple,
        .brown,
        .cyan,
        .green,
        .indigo,
        .mint,
        .orange,
        .pink
    ]
    
    @State var colorNum = 0
    @State private var fullText: String = ""
    @State var fontSize: Double = 20.0
    @State var fontColor: Color = .black
    @State var selectedFont = "Pilseung Gothic Regular"
    @State var renderedImage: Image = Image("sticker_fire")
    

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $fullText)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .multilineTextAlignment(.leading)
                    .foregroundColor(fontColor)
                    .font(Font.custom(selectedFont,  size: fontSize))
                    .lineSpacing(5)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("cancel")
                                .onTapGesture {
                                    /// BoardEditView로 이동
                                }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Text(.init(systemName: "checkmark"))
                                .onTapGesture {
                                    /// 이미지 렌더 후
                                    /// BoardEditView로 renderImage 전달
                                    self.renderImage(text: fullText)
                                }
                        }
                        
                    }
                    .foregroundColor(.green)

                /// font 선택
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(fontArr, id: \.self) { fontItem in
                            VStack {
                                Text(fontItem.korName)
                                    .font(Font.custom(fontItem.engName,  size: 20))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 60)
                            .background(selectedFont == fontItem.engName ? .brown : .white)
                            .foregroundColor(selectedFont == fontItem.engName ? .white : .black)
                            .cornerRadius(CGFloat(10))
                            .onTapGesture {
                                selectedFont = fontItem.engName
                            }
                        }
                    }
                }
                
                
                /// fontColor 선택
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack {
                        ForEach(0..<colorArr.count, id: \.self) { colorIndex in
                            Circle()
                                .frame(width: colorNum == colorIndex ? 40 : 30)
                                .foregroundColor(colorArr[colorIndex])
                                .onTapGesture {
                                    fontColor = colorArr[colorIndex]
                                    withAnimation(.easeInOut(duration: 0.36)) {
                                        colorNum = colorIndex
                                    }
                                }
                        }
                    }
                }
                
                /// fontSize 선택
                HStack {
                    Text("a")
                    Slider(value: $fontSize, in: 10...50, step: 1) { change in
                        print(change)
                    }
                    Text("A")
                }
            
            }
            .padding()
        }
    }
}

/// Text to Image
struct RenderView: View {
    let text: String
    let fontSize: Double
    let fontType: String
    let color: Color

    var body: some View {
        Text(text)
            .font(Font.custom(fontType,  size: fontSize))
            .foregroundColor(color)
    }
}

extension TutorialTextEditView {

    @MainActor func renderImage(text: String = ""){
        let renderer = ImageRenderer(
            content: RenderView(
                text: text,
                fontSize: self.fontSize,
                fontType: self.selectedFont,
                color: self.fontColor
            )
        )
        
        renderer.scale = displayScale
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

struct TutorialTextEditView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialTextEditView()
    }
}

