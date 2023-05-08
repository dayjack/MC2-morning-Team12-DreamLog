//
//  TutorialView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialView: View {
    
    
    @State var tutorialImage = UIImage(named: "DashPlus")!
    @State var tutorialText: String = ""
    
    @EnvironmentObject var data : TutorialBoardElement //
    
    @State var isActive: Bool = false
    @State var showEdit: Bool = false
    @State var showSheet: Bool = false
    
    @State var index: Int = 0
    @State var titleArr: [String] = [
        "현재 가장 이루고 싶은\n 가장 중요한 목표는 무엇인가요?",
        "지금 목표를 다 이룬 후\n꼭 하고 싶은 일이 있나요?",
        "본인이 가장 힘든 순간에\n듣고 싶은 말을 생각해보세요."
    ]
    @State var subTitleArr: [String] = [
        "가장 중요한 목표를 의미하는\n사진을 올리거나 적어주세요",
        "하고 싶은 일을 적어주세요",
        "가장 듣고싶은 응원을 적어주세요"
    ]
    
    var body: some View {
        
        let binding = Binding<String>(
            get: { self.tutorialText },
            set: {
                self.tutorialText = $0
                self.textFieldChanged()
            }
        )
        
        BgColorGeoView { geo in
            
            let width = geo.size.width
            
                VStack {
                    
                    Text(titleArr[index])
                        .brownText()
                        .padding()
                        .padding(.top, 40)

                    Text(subTitleArr[index])
                        .grayText()

                    TextField("placeholder", text: binding)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.vertical, 18)
                    
                    if index < 2 {
                        Image(uiImage: tutorialImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 22)
                            .onTapGesture {
                                isActive = true
                                showSheet = true
                            }
                    }
                    Spacer()
                    NavigationLink(value: showEdit, label: {
                        Button {
                            
                            if !tutorialImage.isEqual(UIImage(named: "DashPlus")!) {
                                
                                data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:Double.random(in: 0...300), y:Double.random(in: 0...300)), imageWidth: 200, imageHeight: (tutorialImage.size.height / tutorialImage.size.width * 200), angle: .degrees(0), angleSum: 0, picture: Image(uiImage: tutorialImage)))
                                self.tutorialImage = UIImage(named: "DashPlus")!
                            }
                            
                            if self.tutorialText != ""  {
                                data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:Double.random(in: 0...300), y:Double.random(in: 0...300)), imageWidth: 200, imageHeight: (textToImage(text: self.tutorialText).size.height / textToImage(text: self.tutorialText).size.width * 200), angle: .degrees(0), angleSum: 0, picture: Image(uiImage: textToImage(text: self.tutorialText))))
                                tutorialText = ""
                            }
                            
                            if index == 2 {
                                showEdit = true
                            } else {
                                withAnimation(.easeIn(duration: 0.4)) {
                                    isActive = false
                                    index += 1
                                }
                            }
                        } label: {
                            Text("다음으로")
                                .frame(width: abs(width - 40),height: 60)
                                .brownButton(isActive: isActive)
                        }
                    })
                    .allowsHitTesting(isActive)
                    .navigationDestination(isPresented: $showEdit) {
                        TutorialBoardView()
                    }
                }
            .frame(width: abs(width - 40))
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$tutorialImage)
        }
        .onAppear {
            tutorialImage = UIImage(named: "DashPlus")!
            index = 0
            data.viewArr.removeAll()
        }
        .ignoresSafeArea(.keyboard)
        
    }
}
// MARK: - Preview
struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPreview {
            TutorialView()
        }
    }
}

// MARK: - extension
extension TutorialView {
    
    private func textFieldChanged() {
        if tutorialText != "" || !tutorialImage.isEqual(UIImage(named: "DashPlus")!) {
            isActive = true
        } else {
            isActive = false
        }
    }
}

