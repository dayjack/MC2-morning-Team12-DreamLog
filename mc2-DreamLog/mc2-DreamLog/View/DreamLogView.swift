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
    @State var boardList: [DreamLogModel] = []
    @State var detailLogImage: UIImage = UIImage()
    @State var detailLogTime: String = String()
    @State var index: Int = 0
    
    var body: some View {
        BgColorGeoView { geo in
            ScrollView {
                Text("드림보드의 기록들")
                    .brownText()
                    .padding(.top, 20)
                    .padding(.bottom, 4)
                Text("이제까지 만든 드림보드의 기록입니다.")
                    .grayText(fontSize: 12)
                LazyVStack(spacing: 0) {
                    ForEach(Array(boardList.enumerated()), id: \.1.id) { idx, data in
                        ZStack {
                            
                            Button {
                                print("====onTapGesture=====")
                                index = idx
                                showDetailView = true
                            } label: {
                                Image(uiImage: ImageFileManager.shared.getSavedImage(named: data.imagePath)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 320)
                            }
                            VStack(spacing: 0) {
                                Spacer()
                                Text(data.time)
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
            .onAppear {
                print("====readDreamLogData=====")
                boardList = DBHelper.shared.readDreamLogData()
            }
            .sheet(isPresented: $showDetailView) {
                ScrollView {
                    VStack(alignment: .center) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.textGray)
                            .padding(.top)
                        Spacer()
                            .frame(height: 20)
                        Image(uiImage: self.detailLogImage)
                        VStack(spacing: 0) {
                            Spacer()
                            Text(self.detailLogTime)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .font(Font.system(size: 18, weight: Font.Weight.bold))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                            .frame(height: 20)
                    }
                }
                .onAppear {
                    self.detailLogImage = ImageFileManager.shared.getSavedImage(named: boardList[index].imagePath)!
                    self.detailLogTime = boardList[index].time
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
