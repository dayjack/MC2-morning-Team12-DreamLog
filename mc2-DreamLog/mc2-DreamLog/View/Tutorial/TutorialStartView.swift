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
    @State var yOffsetTop = -40.0
    @State var yOffsetBottom = -40.0
    @State var opacityAni = 0.0
    
    var body: some View {
        NavigationStack {
            BgColorGeoView { geo in
                
                let width = geo.size.width
                
                ZStack {
                    
                    
                    VStack(spacing: 20) {
                        Image("TutoStart2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width / 2)
                            .cornerRadius(5)
                            .shadow(color: Color.shadowGray, radius: 4)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1).delay(1.5)) { self.yOffsetTop = -150.0 }
                            }
                            .offset(y: yOffsetTop)
                        
                        Image("TutoStart1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width / 2)
                            .cornerRadius(5)
                            .shadow(color: Color.shadowGray, radius: 4)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1).delay(1.7)) { self.yOffsetBottom = -150.0 }
                            }
                            .offset(y: yOffsetBottom)
                    }
                    
                    
                    VStack {
                        Spacer()
                        
                        
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
                    .opacity(opacityAni)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5).delay(2.4)) { self.opacityAni = 1 }
                        UserDefaults.standard.set(geo.size.width / 2, forKey: "TutorialBoardWidthCenter")
                        UserDefaults.standard.set((geo.size.height / 2) - 75, forKey: "TutorialBoardHeightCenter")
                        print("first: \(UserDefaults.standard.double(forKey: "TutorialBoardWidthCenter"))")
                    }
                }
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
