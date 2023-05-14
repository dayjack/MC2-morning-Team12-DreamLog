//
//  TuturialBoardView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI
import WidgetKit

struct TutorialBoardView: View {
    /// widget 사이즈 보여줌
    @State var widgetSize = WidgetSize.none
    @State var showScroll: Bool = false
    @State var goToCalender = false
    
    @EnvironmentObject var data: TutorialBoardElement
    @GestureState var startLocation: CGPoint? = nil
    @EnvironmentObject var FUUID: FocusUUID
    
    
    @State var dataArray: [BoardElement] = []
    @State var loadingViewShowing = false
    
    let backgroundUUID = UUID()
    
    var body: some View {
        LoadingView(isShowing: $loadingViewShowing){
            BgColorGeoView { geo in
                
                let width = geo.size.width
                
                VStack(spacing: 0) {
                    // 편집될 뷰로 교체하기
                    
                    zstackView(geo: geo)
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
                        
                        NavigationLink(value: goToCalender) {
                            Text("완료")
                                .frame(width: abs(width - 40) / 2,height: 60)
                                .brownButton(isActive: true)
                                .onTapGesture {
                                    loadingViewShowing = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        
                                        
                                        
                                        
                                        
                                        loadingViewShowing = false
                                        FUUID.focusUUID = backgroundUUID
                                        generateImage(geo: geo)
                                        // 데이터
                                        DBHelper.shared.createDreamLogTable()
                                        // 제대로 된 더미 데이터 넣어주기
                                        DBHelper.shared.insertDreamLogData(img: Tab1Model.instance.image ?? UIImage(named: "sticker_check")!)
                                        
                                        // MARK: - widget code
                                        let widgetImageName: String = DBHelper.shared.readDreamLogDataOne().imagePath
                                        UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue(widgetImageName, forKey: "WidgetImageName")
                                        print("tutorial Board : \(widgetImageName)")
                                        WidgetCenter.shared.reloadTimelines(ofKind: "DreamBoardWidget")
                                        
                                        
                                        goToCalender = true
                                    }
                                    /// 이미지 캡쳐 기능 구현
                                    
                                    
                                    
                                }
                        }
                        .navigationDestination(isPresented: $goToCalender) {
                            TutorialCalendarView()
                        }
                        
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
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
    
    func generateImage(geo: GeometryProxy) {
        guard let uiImage = ImageRenderer(content: zstackView(geo: geo)).uiImage else {
            return
        }
        Tab1Model.instance.image = uiImage
    }
}


struct DreamLogTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        
        MultiPreview {
            TutorialBoardView()
        }
    }
}


extension TutorialBoardView {
    
    func zstackView(geo: GeometryProxy) -> some View {
        let width = geo.size.width
        let boardHeight = geo.size.height - 250
        
        return ZStack {
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
        .frame(width: width,height: boardHeight)
        
    }
}
