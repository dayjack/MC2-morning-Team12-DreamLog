//
//  DreamLogView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/11.
//

import SwiftUI

struct DreamLogView: View {
    @State var tab1Model = Tab1Model()
    @State var boardList = [
        UIImage(named: "BoardDummy")
    ]
    
    var body: some View {
    
        ScrollView {
            VStack(spacing: 0) {
                ForEach(boardList, id: \.self) { boardImage in
                    ZStack {
                        Image(uiImage: boardImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 320)
                        
                        VStack(spacing: 0) {
                            Spacer()
                            Text("2023.04.01 ~ 2023.04.25")
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .font(Font.system(size: 20, weight: Font.Weight.bold))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                            .frame(height: 20)
                    }
                    .cornerRadius(20)
                    .shadow(color: Color.shadowGray, radius: 4)
                    .padding()
                    
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
