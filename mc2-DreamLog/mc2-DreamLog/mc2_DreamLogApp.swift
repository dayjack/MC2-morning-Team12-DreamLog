//
//  mc2_DreamLogApp.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/02.
//

import SwiftUI
import CoreData

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
                            _ = DBHelper.shared.createDB()
//                            DBHelper.shared.dropTable(tableName: "Element")
                        }
                        .environment(\.managedObjectContext, persistentContainer.viewContext)
                }
                .environmentObject(TutorialBoardElement())
                .environmentObject(FocusUUID())
                .tint(.activeBrown)
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

var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CoreData")
    container.loadPersistentStores(completionHandler: { (storeDesc, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("\(nserror), \(nserror.userInfo)")
        }
    }
}
