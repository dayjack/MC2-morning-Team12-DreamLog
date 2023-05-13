//
//  DDayCalendarView.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/12.
//

import SwiftUI

struct DDayCalendarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showDDayCalendar: Bool
    
    @State private var isNextViewActive = false
    @State private var date = Date()
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
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

                HStack {
                    Button("취소") {
                        showDDayCalendar.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: abs(width - 40) / 2, height: 60)
                    .whiteWithBorderButton()

                    Button("완료") {
                        UserDefaults.standard.set(date, forKey: "selectedDate")
                        UserDefaults.standard.synchronize()
                        
                        showDDayCalendar.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: abs(width - 40) / 2, height: 60)
                    .brownButton(isActive: true)
                }

            }
            .padding()
        }
    }
}

//struct DDayCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiPreview {
//            DDayCalendarView()
//        }
//    }
//}
