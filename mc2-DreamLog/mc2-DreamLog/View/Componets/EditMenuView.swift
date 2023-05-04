//
//  EditMenuView.swift
//  OutSourcing
//
//  Created by ChoiYujin on 2023/05/04.
//


/*
 수정중, 구조가 바뀔 수 있습니다
 메뉴 위 공백을 채우기 위해서 색깔버튼과 슬라이더를 임시로 추가했습니다.
 */

import SwiftUI

struct EditMenuView: View {
    
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
    @State var btnNames: [String] = [
        "hand.draw",
        "character",
        "paintbrush.pointed",
        "photo",
        "face.smiling",
        "rectangle"
    ]
    
    var body: some View {
        
        VStack{
            // 색상 고르는 뷰 & 펜 두꺼움 고르는 슬라이더
            // EditColorView
            VStack {
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack {
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
                }
                .padding(.horizontal)
                
                HStack {
                    Circle().foregroundColor(.textGray).frame(width: 10)
                    Slider(value: $sliderValue, in: 1...30, step: 1)
                        .padding(.horizontal, 20)
                    
                    Circle().foregroundColor(.textGray).frame(width: 30)
                }
                .padding(.horizontal, 20)
            }
            
            // 메인 편집 설정 창
            // EditMenuView
            HStack {
                Spacer()
                ForEach(btnNames, id: \.self) { name in
                    Button {
                        print("clicked")
                    } label: {
                        Image(systemName: name)
                            .foregroundColor(.secondary)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                }
                .padding(.bottom, 20)
                //                .padding(.top, 80)
                Spacer()
            }
        }
    }
}

struct EditBar_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            EditMenuView()
        }
    }
}
