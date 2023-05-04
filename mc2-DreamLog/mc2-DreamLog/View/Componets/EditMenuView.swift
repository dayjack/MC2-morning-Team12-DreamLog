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
    @State var image = UIImage()
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
                    print("log")
                    data.viewArr.append(
                        .init(offsetX: Double.random(in: -100...100), offsetY: Double.random(in: -100...100), elementView: Image(uiImage: self.image))
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
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
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
