//
//  TutorialView.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TutorialView: View {
    
    
    @State var image = UIImage(named: "DashPlus")!
    @State var text: String = ""
    
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
            get: { self.text },
            set: {
                self.text = $0
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
                        Image(uiImage: image)
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
                            
                            if !image.isEqual(UIImage(named: "DashPlus")!) {
                                
                                data.viewArr.append(BoardElement.init(offsetX: Double.random(in: -100...100), offsetY: Double.random(in: -100...100), elementView: Image(uiImage: self.image)))
                                self.image = UIImage(named: "DashPlus")!
                            }
                            
                            if self.text != ""  {
                                data.textArr.append(self.text)
                                text = ""
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
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .onAppear {
            image = UIImage(named: "DashPlus")!
            index = 0
            data.textArr.removeAll()
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
        if text != "" || !image.isEqual(UIImage(named: "DashPlus")!) {
            isActive = true
        } else {
            isActive = false
        }
    }
}

