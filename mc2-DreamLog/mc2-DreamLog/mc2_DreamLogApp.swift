//
//  mc2_DreamLogApp.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/02.
//

import SwiftUI

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
                    }
                
            }
        }
    }
}
