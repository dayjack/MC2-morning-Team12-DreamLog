//
//  TutorialWidgetView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialWidgetView: View {
    
    var body: some View {
        BgColorGeoView { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
                Spacer()
                Text("만드신 드림로그는\n위젯으로 설정할 수 있어요!")
                    .brownText()
                    .frame(width: abs(width - 40),alignment: .center)
                    .padding(.bottom, 20)

                Text("바탕화면에 드림로그를 추가해서\n목표와 오늘의 응원을 확인해보세요.")
                    .grayText()
                Image("widgetMainscreen")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: height / 2)
                Spacer()
                
                NavigationLink {
                    MainView()
                } label: {
                    Text("다음으로")
                        .frame(width: abs(width - 40),height: 60)
                        .brownButton(isActive: true)
                }
            }
            .padding()
        }
    }
}

struct WidgetTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            TutorialWidgetView()
        }
        
    }
}

