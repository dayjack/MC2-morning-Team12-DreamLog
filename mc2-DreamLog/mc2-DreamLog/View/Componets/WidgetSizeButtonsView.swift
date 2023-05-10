//
//  WidgetSizeButtonsView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/10.
//

import SwiftUI

enum WidgetSize: String {
    case square = "square"
    case rectangle = "rectangle"
    case none = ""
}

struct WidgetSizeButtonsView: View {
    let widgetSizeList: [WidgetSize] = [
        .square,
        .rectangle,
    ]
    @Binding var widgetSize: WidgetSize
    
    var body: some View {
        HStack {
            Text("위젯 사이즈를 확인하세요")
                .padding(.horizontal, 20)
            ForEach(widgetSizeList, id: \.self) { size in
                Button {
                    /// size가 .square와 .rectangle이 있어서 버튼 클릭시 바인딩된 TutorialBoardView에 widgetSize값이 바뀌면서
                    /// WidgetAreaView에 있는 widget사이즈 활성화
                    widgetSize = size
                } label: {
                    Image(systemName: size.rawValue)
                        .foregroundColor(widgetSize == size ? Color.textGreen : .textGray)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
        }
        .frame(height: 60)
    }
}

//struct WidgetSizeButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetSizeButtonsView()
//    }
//}
