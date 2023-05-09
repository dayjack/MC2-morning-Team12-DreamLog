//
//  EmojiPicker.swift
//  mc2-DreamLog
//
//  Created by Seungui Moon on 2023/05/09.
//

import SwiftUI

struct EmojiPicker: View {
    @EnvironmentObject var data: TutorialBoardElement
    
    let emojiList: [String] = [
        "sticker_fire",
        "sticker_love",
        "sticker_like",
        "sticker_flag",
        "sticker_desk",
        "sticker_check",
        "sticker_run",
        "sticker_start",
        "sticker_trophy",
        "sticker_break",
        "sticker_good",
        "sticker_never",
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.emojiList, id: \.self){ emoji in
                    Image(emoji)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .onTapGesture {
                            guard let image = UIImage(named: emoji) else {
                                return
                            }
                            data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:0, y:0), imageWidth: (image.size.width > image.size.height) ?  200 : (image.size.width / image.size.height * 200), imageHeight: (image.size.width > image.size.height) ? (image.size.height / image.size.width * 200) : 200, angle: .degrees(0), angleSum: 0, picture: Image(uiImage: image)))
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker()
    }
}
