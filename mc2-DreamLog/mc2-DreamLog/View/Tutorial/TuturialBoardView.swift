//
//  TuturialBoardView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialBoardView: View {
    
    @State var showScroll: Bool = false
    
    @EnvironmentObject var data: TutorialBoardElement
    
    var body: some View {
        BgColorGeoView { geo in
            
            let width = geo.size.width
            //                let height = geo.size.height
            VStack {
                // 편집될 뷰로 교체하기
                ZStack {
                    Color.gray.opacity(0.1)
                       
                    
                    ForEach(data.viewArr, id: \.self) { item in
                        
                        item.elementView
                            .resizable()
                            .scaledToFit()
                            .offset(x: item.offsetX, y: item.offsetY)
                            .frame(width: 150)
                    }
                    
                    ForEach(data.textArr, id: \.self) { item in
                        Text(item)
                            .offset(x: Double.random(in: -100...100), y: Double.random(in: -100...100))
                    }
                }
                Spacer()
                EditMenuView()
                HStack {
                    Button {
                        showScroll.toggle()
                    } label: {
                        Text("샘플보기")
                            .frame(width: abs(width - 40) / 2,height: 60)
                            .whiteWithBorderButton()
                    }
                    NavigationLink {
                        TutorialCalendarView()
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


