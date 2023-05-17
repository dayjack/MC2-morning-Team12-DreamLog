//
//  MainView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct MainView: View {
    
    @State var selection = 0
    
    var body: some View {
            BgColorGeoView { geo in
                TabView(selection: $selection) {
                    DreamBoardView()
                        .tabItem {
                            Image(systemName: "list.clipboard")
                            Text("드림보드")
                        }
                        .tag(0)
                    DreamLogView()
                        .tabItem {
                            Image(systemName: "sparkles.rectangle.stack")
                            Text("드림로그")
                        }
                        .tag(1)
                    CheerLogView()
                        .tabItem {
                            Image(systemName: "tray.full")
                            Text("응원로그")
                        }
                        .tag(2)
                }
            }
        .onAppear {
            UserDefaults.standard.set(true, forKey: "gotoMain")
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            MainView()
        }
    }
}
