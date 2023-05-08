//
//  mc2_DreamLogApp.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/02.
//

import SwiftUI

@main
struct mc2_DreamLogApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "gotoMain") {
                NavigationStack {
                    MainView()
                        .onAppear {
                            sleep(2)
                        }
                }
                .tint(.activeBrown)
            } else {
                TutorialStartView() // TutorialStartView
                    .environmentObject(TutorialBoardElement())
                    .environmentObject(FocusUUID())
                    .onAppear {
                        sleep(2)
                    }
                
            }
        }
    }
}
