//
//  mc2_DreamLogApp.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/02.
//

import SwiftUI
import WidgetKit

@main
struct mc2_DreamLogApp: App {
    
    init() {
        Font.registerFonts(fontName: "Pilseung Gothic Regular")
        Font.registerFonts(fontName: "JalnanOTF")
        Font.registerFonts(fontName: "GabiaHeuldot")
        Font.registerFonts(fontName: "The Jamsil OTF 4 Medium")
    }
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "gotoMain") {
                NavigationStack {
                    MainView()
                        .onAppear {
                            sleep(2)
                            // MARK: - widgetcode - 나
                            
//                            let widgetImageName: String = DBHelper.shared.readDreamLogDataOne().imagePath
                            let widgetCheer: String = DBHelper.shared.readCheerLogDataOne().cheer
//                            UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue(widgetImageName, forKey: "WidgetImageName")
//                            print("mc2_DreamLogApp : \(widgetImageName)")
                            UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue(widgetCheer, forKey: "WidgetCheer")
                            WidgetCenter.shared.reloadTimelines(ofKind: "DreamBoardWidget")
                        }
                }
                .environmentObject(TutorialBoardElement())
                .environmentObject(FocusUUID())
                .tint(.activeBrown)
                .onAppear {
                    _ = DBHelper.shared.createDB()
                    DBHelper.shared.createDreamLogTable()
                    DBHelper.shared.createCheerLogTable()
                    
                }
            } else {
                TutorialStartView() // TutorialStartView
                    .environmentObject(TutorialBoardElement())
                    .environmentObject(FocusUUID())
                    .onAppear {
                        sleep(2)
                        _ = DBHelper.shared.createDB()
                        DBHelper.shared.createDreamLogTable()
                        DBHelper.shared.createCheerLogTable()
                        
                        UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue("", forKey: "WidgetImageName")
                        UserDefaults.init(suiteName: "group.mc2-DreamLog")?.setValue("응원을 작성헤보세요!", forKey: "WidgetCheer")
                    }
                
            }
        }
    }
}
