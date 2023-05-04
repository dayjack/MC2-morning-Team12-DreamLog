//
//  DreamBoardView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct DreamBoardView: View {
    
    @State var text = ""
    
    var body: some View {
        BgColorGeoView { geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
                
                Image("BoardDummy")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 5)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("I")
                        .fontWeight(.bold)
                    Text("D-340")
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                    Image(systemName: "pencil")
                }
                .font(.system(size: 24))
                .padding(.horizontal)
                .foregroundColor(.textGreen)
                
                Rectangle()
                    .frame(width: width, height: 1)
                    .shadow(color: Color.gray.opacity(0.6), radius: 1.5, x: 0, y: 2)
                    .foregroundColor(.bgColor)
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading) {
                    
                    Text("오늘 나에게 주는 응원 한마디")
                    Divider()
                    TextField("ex | 오늘도 한번 열심히 달려보자🔥", text: $text)
                }
                .padding(.horizontal, 16)
                .frame(width: width - 30)
                .frame(height: 100)
                .background(.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}

struct MainTab1View_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            DreamBoardView()
        }
    }
}

