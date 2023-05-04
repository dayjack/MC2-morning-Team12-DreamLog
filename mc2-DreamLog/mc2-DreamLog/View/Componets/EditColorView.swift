//
//  EditColorView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct EditColorView: View {
    
    @State private var sliderValue = 3.0
    @State var colorNum = 0
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
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(0..<colorArr.count, id: \.self) { colorIndex in
                        Circle()
                            .frame(width: colorNum == colorIndex ? 30 : 20)
                            .foregroundColor(colorArr[colorIndex])
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.36)) {
                                    colorNum = colorIndex
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 80)
            
            HStack {
                Circle().foregroundColor(.textGray).frame(width: 10)
                Slider(value: $sliderValue, in: 1...30, step: 1)
                    .padding(.horizontal, 20)
                
                Circle().foregroundColor(.textGray).frame(width: 30)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct EditColorView_Previews: PreviewProvider {
    static var previews: some View {
        EditColorView()
    }
}
