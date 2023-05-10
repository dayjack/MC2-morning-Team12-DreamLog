//
//  WidgetAreaView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/10.
//

import SwiftUI

struct WidgetAreaView: View {
    var boardWidth: CGFloat
    var boardHeight: CGFloat
    @Binding var widgetSize: WidgetSize
    
    var body: some View {
        VStack(spacing: 0) {
            Color.gray
                .frame(
                    width: boardWidth,
                    height: widgetSize == .square ?
                    (boardHeight - boardWidth) / 2 :
                    (boardHeight - boardWidth / 2) / 2
                )
                .opacity(0.4)
            Color.white
                .frame(
                    width: boardWidth,
                    height: widgetSize == .square ?
                    boardWidth : boardWidth / 2
                )
                .opacity(0)
            Color.gray
                .frame(
                    width: boardWidth,
                    height: widgetSize == .square ?
                    (boardHeight - boardWidth) / 2 :
                    (boardHeight - boardWidth / 2) / 2
                )
                .opacity(0.4)
        }
    }
}

//struct WidgetAreaView_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetAreaView()
//    }
//}
