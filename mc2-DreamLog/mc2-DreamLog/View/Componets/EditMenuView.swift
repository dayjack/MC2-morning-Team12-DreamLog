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
    @State var showTextEditView = false
    @State var showEditDrawingView = false
    
    @State var elementImage = UIImage()
    @EnvironmentObject var data: TutorialBoardElement
    @State var editState: EditState = .none
    
    @State var btnNames: [String] = [
        "character",
        "paintbrush.pointed",
        "photo",
        "face.smiling",
        "rectangle"
    ]
    
    @State var btnDictionary: [String : EditState] = [
        "character" : .character,
        "paintbrush.pointed" : .paintbrush,
        "photo" : .photo,
        "face.smiling" : .face,
        "rectangle" : .rectangle
    ]
    
    enum EditState {
        case character, paintbrush, photo, face, rectangle, none
    }
    
    var body: some View {
        
        let binding = Binding<Bool>(
            get: { self.showImagePicker },
            set: {
                if self.showImagePicker && !$0 {
                    
                    data.viewArr.append(
                        .init(imagePosition: CGPoint(x:0, y:0), imageWidth: (elementImage.size.width > elementImage.size.height) ?  200 : (elementImage.size.width / elementImage.size.height * 200), imageHeight: (elementImage.size.width > elementImage.size.height) ? (elementImage.size.height / elementImage.size.width * 200) : 200, angle: .degrees(0), angleSum: 0, picture: Image(uiImage: elementImage))
                    )
                }
                self.showImagePicker = $0
            }
        )
        
        VStack{
            editview(editState: self.editState)
            HStack {
                Spacer()
                ForEach(0..<5, id: \.self) { index in
                    Button {
                        // 나중에 따로 기능 할당. 지금은 모든 버튼 앨범 띄우기로 되어있다.
                        switch index {
                        case 0:
                            editState = btnDictionary[btnNames[index]]!
                            showTextEditView = true
                        case 1:
                            editState = btnDictionary[btnNames[index]]!
                            showEditDrawingView = true
                        case 2:
                            editState = btnDictionary[btnNames[index]]!
                            showImagePicker = true
                        case 3:
                            editState = btnDictionary[btnNames[index]]!
                        case 4:
                            editState = btnDictionary[btnNames[index]]!
                        default:
                            editState = btnDictionary[btnNames[index]]!
                        }
                        
                        
                    } label: {
                        Image(systemName: btnNames[index])
                            .menuButton()
                            .foregroundColor(editState == btnDictionary[btnNames[index]]! ? .textGreen : .textGray)
                    }
                }
                .padding(.bottom, 20)
                Spacer()
            }
        }
        .sheet(isPresented: binding,onDismiss: stateNone) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$elementImage)
        }
        .fullScreenCover(isPresented: $showTextEditView, onDismiss: stateNone) {
            TutorialTextEditView()
        }
        .fullScreenCover(isPresented: $showEditDrawingView, onDismiss: stateNone) {
            EditDrawingView()
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

extension EditMenuView {
    
    func editview(editState: EditState) -> some View {
        return HStack {
            switch editState {
            case .character:
                EmptyView()
            case .paintbrush:
                EmptyView()
            case .photo:
                EmptyView()
            case .face:
                EmojiPicker()
            case .rectangle:
                Text("위젯 관련 뷰가 들어갈 자리")
            case .none:
                EmptyView()
            }
        }
    }
}

extension EditMenuView {
    func stateNone() {
        editState = .none
    }
}
