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
    @State private var showingAlert = false
    
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
                                index = idx
                                getDateLogString(index: 0)
                                showDetailView = true
                            } label: {
                                Image(uiImage: ImageFileManager.shared.getSavedImage(named: data.imagePath)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 320)
                            }
                            VStack(spacing: 0) {
                                Spacer()
                                Text(getDateLogString(index: idx))
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .font(Font.system(size: 14, weight: Font.Weight.bold))
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
                            Text(getDateLogString(index: index))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .font(Font.system(size: 18, weight: Font.Weight.bold))
                                .foregroundColor(Color.gray)
                        }
                        Button {
                            self.showingAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundColor(.red)
                                .padding(.top, 30)
                        }
                        .alert("정말로 드림로그를 삭제하시겠습니까?? 삭제하신 드림로그는 다시 복구할 수 없습니다", isPresented: $showingAlert) {
                            Button("취소", role: .cancel) {
                                
                            }
                            Button("삭제", role: .destructive) {
                                DBHelper.shared.deleteDreamLogData(id: boardList[index].id)
                                boardList.remove(at: index)
                                showDetailView = false
                            }
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

extension DreamLogView {
    
    
    func getDateLogString(index: Int) -> String {
        
        if index == boardList.count - 1 {
            
            let text = dateConverter(inputDateString: boardList[index].time) + " 에 처음 만든 드림보드"
            return text
            
        }
        
        let lastTimeString = dateConverter(inputDateString: boardList[index + 1].time)
        let currnetTimeString = dateConverter(inputDateString: boardList[index].time)
        
        let text = lastTimeString + " 부터 " + currnetTimeString + "까지의 드림보드"
        return text
    }
    
    func dateConverter(inputDateString: String) -> String {
        
        var dateString = inputDateString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString = dateFormatter.string(from: date!)
        
        let calendar = Calendar.current
        let updatedDate = calendar.date(byAdding: .hour, value: 9, to: date!)
        
        let updatedDateString = dateFormatter.string(from: updatedDate!)
        
        return updatedDateString
    }
}
