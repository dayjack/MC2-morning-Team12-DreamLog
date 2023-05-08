//
//  ViewExtension.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

extension View {
    
    func brownText(fontSize: CGFloat = 22) -> some View {
        modifier(TextBrownModifier(fontSize: fontSize))
    }
    
    func brownButton(isActive: Bool = true) -> some View {
        modifier(ButtonBrownModifier(isActive: isActive))
    }
    func whiteWithBorderButton() -> some View {
        modifier(ButtonWhiteBoldModifier())
    }
    
    func grayText(fontSize: CGFloat = 18) -> some View {
        modifier(TextGrayModifier(fontSize: fontSize))
    }
    
    func menuButton() -> some View {
        modifier(MenuButtonModifier())
    }
    
    
    /// Text(String)를 image로 변환해준다. 이미 속성이 전부 적용된 텍스트뷰를 이미지로 바꾸는 형식이 아님
    /// - Parameters:
    ///   - text: 텍스트뷰에 들어가야할 텍스트
    ///   - backgroundColor: 배경색, 기본은 투명색이다
    ///   - textColor: 글자색, 기본은 검은색이다
    /// - Returns: 속성이 적용된 텍스트가 여백없이 UIImage 형태로 반환
    func textToImage(text: String, backgroundColor: UIColor = .clear, textColor: UIColor = .black) -> UIImage {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100)
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.text = text
        
        label.sizeToFit() // Size the label to fit the text
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

