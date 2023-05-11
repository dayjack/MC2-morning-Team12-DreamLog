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
                            Image(systemName: "menucard")
                            Text("비전보드")
                        }
                        .tag(0)
                    Text("Another Tab")
                        .tabItem {
                            Image(systemName: "2.square.fill")
                            Text("비전로그")
                        }
                        .tag(1)
                    CheerLogView()
                        .tabItem {
                            Image(systemName: "3.square.fill")
                            Text("응원로그")
                        }
                        .tag(2)
                }
            }
        .onAppear {
            UserDefaults.standard.set(true, forKey: "gotoMain")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
//            if selection == 0 {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        print("+ clicked")
//                    } label: {
//                        Image(systemName: "plus")
//                            .foregroundColor(.textGreen)
//                            .font(.system(size: 22))
//                    }
//                }
//            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            MainView()
        }
    }
}
