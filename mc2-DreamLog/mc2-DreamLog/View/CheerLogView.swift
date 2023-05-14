//
//  CheerLogView.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/04.
//

import SwiftUI
import WidgetKit

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
                Divider()
                Spacer()
                
                CheerList()
            }
        }
    }
}



struct CheerList: View {
    
    @State var cheerList: [CheerLogModel] = []
    
    var body: some View {
        VStack {
            
            List{
                
                ForEach(Array(cheerList.enumerated()), id: \.1) { (index, cheerData) in
                    VStack(alignment: .leading) {
                        Text(cheerData.cheer)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 8)
                        
                        
                        Text(dateConverter(inputDateString: cheerData.time))
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                }
                .onDelete { indexSet in
                    let indexes = indexSet.map { $0 }
                    for index in indexes {
                        let cheerData = cheerList[index]
                        let i = cheerList.firstIndex(of: cheerData)!
                        DBHelper.shared.deleteCheerLogData(id: cheerList[i].id)
                        cheerList = DBHelper.shared.readCheerLogData()
                        print("cheerList.count : \(cheerList.count)")
                        if cheerList.count == 0 {
                            UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue("응원을 작성해 보세요!", forKey: "WidgetCheer")
                        } else {
                            print("delete : \(cheerList.count - 1)")
                            
                            UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue(cheerList[0].cheer, forKey: "WidgetCheer")
                        }
                        WidgetCenter.shared.reloadTimelines(ofKind: "DreamBoardWidget")
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .shadow(color: Color.shadowGray, radius: 4)
            .background(Color.bgColor)
            .onAppear {
                self.cheerList = DBHelper.shared.readCheerLogData()
            }
        }
    }
}

struct CheerLogView_Previews: PreviewProvider {
    static var previews: some View {
        CheerLogView()
    }
}
