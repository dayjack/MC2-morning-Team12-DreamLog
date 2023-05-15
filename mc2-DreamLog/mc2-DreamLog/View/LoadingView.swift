//
//  LoadingView.swift
//  mc2-DreamLog
//
//  Created by 이재혁 on 2023/05/13.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool  // should the modal be visible?
    var content: () -> Content
    var text: String? = "보드 저장중" // the text to display under the ProgressView - defaults to "Loading..."
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                // the content to display - if the modal is showing, we'll blur it
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 3 : 0)
                
                // all contents inside here will only be shown when isShowing is true
                if isShowing {
                    // this Rectangle is a semi-transparent black overlay
                    Rectangle()
                        .fill(Color.black).opacity(isShowing ? 0.5 : 0)
                        .edgesIgnoringSafeArea(.all)
                    
                    // the magic bit - our ProgressView just displays an activity
                    // indicator, with some text underneath showing what we are doing
                    VStack(spacing: 15) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            .scaleEffect(1.5, anchor: .center)
                            .foregroundColor(Color.white)
                        Text(text ?? "보드 저장중")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

