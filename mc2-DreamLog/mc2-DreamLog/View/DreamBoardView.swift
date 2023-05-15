//
//  DreamBoardView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI
import WidgetKit

struct DreamBoardView: View {
    @EnvironmentObject var data: TutorialBoardElement
    @State var isDone = false
    @State var cheertext = ""
    @State var alerttext = ""
    @State private var showingAlert: Bool = false
    @State private var confirmAlert: Bool = false
    @State private var boardImage: UIImage? = Tab1Model.instance.image
    
    @State private var showDDayCalendar = false
    
    @State private var dDayString = "calendar"
    
    let imageFileManager = ImageFileManager.shared
    
    var photo: TransferableUIImage {
        return .init(uiimage: boardImage ?? UIImage(named: "MainDummyImage")!, caption: "드림보드를 공유해보세요🚀")
    }
    
    var body: some View {
        
        BgColorGeoView { geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
                Spacer()
                    .frame(height: 20)
                Image("dreamLog")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Spacer()
                VStack(spacing: 0) {
                    
                    if boardImage != nil {
                        Image(uiImage: boardImage ?? UIImage(named: "MainDummyImage")!)
                    } else {
                        VStack {
                            Spacer()
                            Image("MainDummyImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width / 2)
                            Spacer()
                        }
                        .frame(width: width)
                        .background(Color.white)
                    }
                }
                
                    
                
                
                HStack {
                    if let selectedDate = UserDefaults.standard.object(forKey: "selectedDate") as? Date {
                        
                        NavigationLink(destination: DDayCalendarView(showDDayCalendar: $showDDayCalendar)) {
                            Text(dDayString)
                                .fontWeight(.bold)
                                .font(.system(size: 26))
                        }
                        
                    } else {
                        NavigationLink(destination: DDayCalendarView(showDDayCalendar: $showDDayCalendar)) {
                            Image(systemName: dDayString)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                                .padding(5)
                        }
                    }
                    Spacer()
                    ShareLink(item: photo, preview: SharePreview(
                        photo.caption,
                        image: photo.image)) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                        }
                    Spacer()
                        .frame(width: 20)
                    NavigationLink(value: isDone, label:{
                        Button {
                            isDone = true
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                        }
                    })
                    .navigationDestination(isPresented: $isDone, destination: {
                        DreamBoardEditView()
                    })
                }
                .font(.system(size: 24))
                .padding(.horizontal)
                .foregroundColor(.textGreen)
                
                Rectangle()
                    .frame(width: width, height: 1)
                    .shadow(color: Color.gray.opacity(0.6), radius: 1.5, x: 0, y: 2)
                    .foregroundColor(.bgColor)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading) {

                    Button {
                        showingAlert = true
                    } label: {
                        Text(cheertext == "" ? "스스로를 위한 응원을 작성해보세요" : cheertext)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.textGreen)
                    }
                    .alert("나에게 주는 응원 한 마디를\n작성해주세요", isPresented: $showingAlert, actions: {
                        TextField("응원의 한 마디를 작성해보아요", text: $alerttext)
                        
                        Button("완료", action: {
                            confirmAlert = true
                        })
                        Button("취소", role: .cancel, action: {
                            alerttext = ""
                        })
                    })
                    .alert(isPresented: $confirmAlert, content: {
                        Alert(title: Text("\(alerttext)으로\n응원을 추가하시겠어요?"),
                              message: Text("작성하신 응원은 위젯에 표시됩니다."),
                              primaryButton: .default(Text("확인"), action: {
                            // 데이터 처리
                            DBHelper.shared.createCheerLogTable()
                            DBHelper.shared.insertCheerLogData(alerttext)
                            cheertext = DBHelper.shared.readCheerLogDataOne().cheer
                            alerttext = ""
                            UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue(cheertext, forKey: "WidgetCheer")
                            WidgetCenter.shared.reloadTimelines(ofKind: "DreamBoardWidget")
                        }), secondaryButton: .cancel(Text("취소"), action: {
                            cheertext = DBHelper.shared.readCheerLogDataOne().cheer
                            alerttext = ""
                        }))
                        
                    })

                }
                .padding(.horizontal, 16)
                .frame(width: width - 30)
                .frame(height: 50)
                .background(.white)
                .cornerRadius(12)
                .padding(.bottom, 20)
                .shadow(color: Color.shadowGray, radius: 2, x: 0, y: 2)
            }
            .onAppear {
                getDDayDate()
                self.boardImage = imageFileManager.getSavedImage(named: DBHelper.shared.readDreamLogDataOne().imagePath)
                cheertext = DBHelper.shared.readCheerLogDataOne().cheer
            }
        }
    }
    
}


extension DreamBoardView {
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    private func getDDayDate() -> String {
        
        if let skipDate = UserDefaults.standard.object(forKey: "selectedDate") as? String {
            dDayString = skipDate
            return dDayString
        }
        
        if let selectedDate = UserDefaults.standard.object(forKey: "selectedDate") as? Date {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: Date(), to: tomorrow)
            if let days = components.day {
                dDayString = days > 0 ? "D - \(days)" : (days == 0 ? "D - DAY !" : "D + \(abs(days)+1)")
            }
        }
        return dDayString
    }
    
}


struct MainTab1View_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            DreamBoardView()
        }
    }
}



