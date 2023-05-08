//
//  EditMenuView.swift
//  OutSourcing
//
//  Created by ChoiYujin on 2023/05/04.
//


/*
 수정중, 구조가 바뀔 수 있습니다
 메뉴 위 공백을 채우기 위해서 색깔버튼과 슬라이더를 임시로 추가했습니다.
 */

import SwiftUI

struct EditMenuView: View {
    
    @State var showImagePicker = false
    @State var elementImage = UIImage()
    @EnvironmentObject var data: TutorialBoardElement
    
    @State var btnNames: [String] = [
        "character",
        "paintbrush.pointed",
        "photo",
        "face.smiling",
        "rectangle"
    ]
    
    var body: some View {
        
        let binding = Binding<Bool>(
            get: { self.showImagePicker },
            set: {
                if self.showImagePicker && !$0 {
                    
                    data.viewArr.append(
                        .init(imagePosition: CGPoint(x:Double.random(in: 0...300), y:Double.random(in: 0...300)), imageWidth: 200, imageHeight: (elementImage.size.height / elementImage.size.width * 200), angle: .degrees(0), angleSum: 0, picture: Image(uiImage: elementImage))
                    )
                }
                self.showImagePicker = $0
            }
        )
        
        VStack{
            
            HStack {
                Spacer()
                ForEach(btnNames, id: \.self) { name in
                    Button {
                        // 나중에 따로 기능 할당. 지금은 모든 버튼 앨범 띄우기로 되어있다.
                        showImagePicker = true
                    } label: {
                        Image(systemName: name)
                            .foregroundColor(.secondary)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                            
                    }
                }
                .padding(.bottom, 20)
                .padding(.top, 80)
                Spacer()
            }
        }
        .sheet(isPresented: binding) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$elementImage)
        }
    }
}

struct EditBar_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            EditMenuView()
        }
    }
}
