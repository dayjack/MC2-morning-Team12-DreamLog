//
//  DreamLogView.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/11.
//

import SwiftUI

struct DreamLogView: View {
    @State var tab1Model = Tab1Model()
    @State var showDetailView = false
    @State var boardList = [
        UIImage(named: "BoardDummy")
    ]
    
    var body: some View {
        BgColorGeoView { geo in
            ScrollView {
                Text("드림보드의 기록들")
                    .brownText()
                    .padding(.top, 20)
                    .padding(.bottom, 4)
                Text("이제까지 만든 드림보드의 기록입니다.")
                    .grayText(fontSize: 12)
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
                        .onTapGesture {
                            showDetailView = true
                        }
                        
                    }
                    
                }
            }
            .sheet(isPresented: $showDetailView) {
                ScrollView {
                    VStack(alignment: .center) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.textGray)
                            .padding(.top)
                        Spacer()
                            .frame(height: 20)
                        Image(uiImage: boardList[0]!)
                        VStack(spacing: 0) {
                            Spacer()
                            Text("2023.04.01 부터 2023.04.25까지의 드림보드")
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .font(Font.system(size: 18, weight: Font.Weight.bold))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                            .frame(height: 20)
                    }
                }
                .background(Color.bgColor)
            }
        }
    }
}

struct DreamLogView_Previews: PreviewProvider {
    static var previews: some View {
        DreamLogView()
    }
}
