//
//  EditDrawingMenuView.swift
//  mc2-DreamLog
//
//  Created by Park Jisoo on 2023/05/05.
//

import SwiftUI



struct EditDrawingMenuView: View {
    @Binding var sliderValue: Double
    @Binding var colorNum: Int
    @Binding var colorArr: [Color]
    @Binding var isDraw : Bool
    
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                if isDraw
                {
                    ForEach(0..<colorArr.count, id: \.self) { colorIndex in
                        Circle()
                            .frame(width: colorNum == colorIndex ? 40 : 30)
                            .foregroundColor(colorArr[colorIndex])
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.36)) {
                                    colorNum = colorIndex
                                }
                            }
                    }
                }
            }}
        .padding(.horizontal)
        
        HStack {
            Circle().foregroundColor(.textGray).frame(width: 10)
            Slider(value: $sliderValue, in: 1...30, step: 1)
                .padding(.horizontal, 20)
            Circle().foregroundColor(.textGray).frame(width: 30)
        }
        .padding(.horizontal, 20)
        .padding(.top, isDraw ? 0 : 40)
    }
}
