//
//  TutorialCalendarView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialCalendarView: View {
    

    @State private var isNextViewActive = false
    @State private var date = Date()
    
    var body: some View {
        BgColorGeoView { geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
                Spacer()
                Text("목표로 하는 날을 입력해주세요")
                    .padding(.bottom, 10)
                    .brownText()
                Text("바탕화면에 드림로그를 추가해서\n목표와 오늘의 응원을 확인해보세요.")
                    .grayText()

                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                Spacer()
                
                NavigationLink(destination: MainView(), isActive: $isNextViewActive) {
                    EmptyView()
                }
                HStack {
                    Button("생략할래요") {
                        isNextViewActive = true
                    }
                    .frame(width: abs(width - 40) / 2, height: 60)
                    .whiteWithBorderButton()

                    NavigationLink(destination: MainView(), isActive: $isNextViewActive) {
                        Button("시작하기") {
                            UserDefaults.standard.set(date, forKey: "selectedDate")
                            UserDefaults.standard.synchronize()
                            isNextViewActive = true
                        }
                        .frame(width: abs(width - 40) / 2, height: 60)
                        .brownButton(isActive: true)
                    }
                }

            }
            .padding()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            TutorialCalendarView()
        }
    }
}

