//
//  TutorialStartView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialStartView: View {
    
    @State var isLoading: Bool = true
    @State var isActive: Bool = true
    @State var showTutorial: Bool = false
    
    var body: some View {
        NavigationStack {
            BgColorGeoView { geo in
                
                let width = geo.size.width
                
                VStack {
                    Spacer()
                    
                    Image("TutoSheet2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width / 2.8)
                    
                    Text("꿈을 현실로 만들기 위한 나만의 드림로그\n 불안과 무기력이 찾아오면 드림로그를 통해\n 나의 목표를 상기시켜보세요")
                        .brownText(fontSize: 18)
                    
                    NavigationLink {
                        TutorialView()
                    } label: {
                        Text("시작하기")
                            .frame(width: abs(width - 40), height: 60)
                            .brownButton(isActive: isActive)
                    }
                    
                }
                .padding()
            }
        }
        .tint(.activeBrown)
    }
}

struct TutorialStartView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            TutorialStartView()
        }
    }
}
