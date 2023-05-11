//
//  TuturialBoardView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialBoardView: View {
    /// widget 사이즈 보여줌
    @State var widgetSize = WidgetSize.none
    @State var showScroll: Bool = false
    
    @EnvironmentObject var data: TutorialBoardElement
    @GestureState var startLocation: CGPoint? = nil
    @EnvironmentObject var FUUID: FocusUUID
    
    let backgroundUUID = UUID()
    
    var body: some View {
        BgColorGeoView { geo in
            
            let width = geo.size.width
            let boardHeight = geo.size.height - 220
            VStack(spacing: 0) {
                // 편집될 뷰로 교체하기
                ZStack {
                    Color.white
                       
                    
                    ForEach(data.viewArr, id: \.self) { item in
                        
                        FixableImageView()
                            .environmentObject(item)
                            .environmentObject(data)
                            .environmentObject(FUUID)
                    }
                    /// widgetSize가 .none인 경우에는 보여지지 않음
                    if widgetSize != .none {
                        WidgetAreaView(
                            boardWidth: width,
                            boardHeight: boardHeight,
                            widgetSize: $widgetSize
                        )
                    }
                }
                .frame(height: boardHeight)
                .padding(.bottom, 10)
                .onTapGesture {
                    FUUID.focusUUID = backgroundUUID
                }
                
                /// EditMenuView - WidgetSizeButtonsView에 widgetSize 설정 버튼이 있어서 widgetSize Binding
                EditMenuView(widgetSize: $widgetSize)
                    
                HStack {
                    Button {
                        FUUID.focusUUID = backgroundUUID
                        showScroll.toggle()
                    } label: {
                        Text("샘플보기")
                            .frame(width: abs(width - 40) / 2,height: 60)
                            .whiteWithBorderButton()
                    }
                    NavigationLink {
                        TutorialCalendarView()
                            .onAppear(perform: {
                                FUUID.focusUUID = backgroundUUID
                            })
                    } label: {
                        Text("완료")
                            .frame(width: abs(width - 40) / 2,height: 60)
                            .brownButton(isActive: true)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $showScroll) {
            ScrollView {
                VStack(alignment: .center) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.textGray)
                        .padding(.top)
                    ForEach(1..<5) { idxnum in
                        Image("TutoSheet\(idxnum)")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            }
        }
    }
}

struct DreamLogTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        
        MultiPreview {
            TutorialBoardView()
        }
    }
}


