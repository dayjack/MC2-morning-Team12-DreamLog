//
//  BgColorGeoView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct BgColorGeoView<Content: View>: View {
    
    let content: (GeometryProxy) -> Content
    
    init(@ViewBuilder content: @escaping (GeometryProxy) -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            
            GeometryReader { geo in
                // 수정중 정렬 맞춤 정령에 필요없는 코드는 다시 정리
                ZStack {
                    content(geo)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}





