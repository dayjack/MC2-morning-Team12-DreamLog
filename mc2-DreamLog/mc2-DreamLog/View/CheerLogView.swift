//
//  CheerLogView.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/04.
//

import SwiftUI

struct CheerLogView: View {
    var body: some View {
        BgColorGeoView { geo in
            VStack {
                Text("나를 향한 응원 로그를 남겨보세요")
                    .brownText()
                    .padding(.top, 20)
                    .padding(.bottom, 4)
                Text("나를 향한 응원 한마디가 기록됩니다.")
                    .grayText(fontSize: 12)
                
                Spacer()
            }
        }
    }
}

struct CheerLogView_Previews: PreviewProvider {
    static var previews: some View {
        CheerLogView()
    }
}
