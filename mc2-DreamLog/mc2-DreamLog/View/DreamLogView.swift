//
//  DreamLogView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/11.
//

import SwiftUI

struct DreamLogView: View {
    @State var boardList = [
        "BoardDummy"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(boardList, id: \.self) { boardImage in
                    ZStack {
                        Image(uiImage: UIImage(named: boardImage)!)                                                         
                    }
                    .cornerRadius(20)
                }
                
            }
        }
    }
}

struct DreamLogView_Previews: PreviewProvider {
    static var previews: some View {
        DreamLogView()
    }
}
