//
//  MultiPreview.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct MultiPreview<Content>: View where Content: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationStack {
            content()
        }
        .previewDisplayName("iPhone SE (3rd generation)")
        .environmentObject(TutorialBoardElement())
        NavigationStack {
            content()
        }
        .previewDevice("iPhone 14 Pro")
        .previewDisplayName("iPhone 14 Pro")
        .environmentObject(TutorialBoardElement())
        NavigationStack {
            content()
        }
        .previewDevice("iPhone 13 mini")
        .previewDisplayName("iPhone 13 mini")
        .environmentObject(TutorialBoardElement())
    }
}



