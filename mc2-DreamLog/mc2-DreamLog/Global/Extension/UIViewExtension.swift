//
//  UIViewExtension.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/12.
//

import Foundation
import SwiftUI


extension UIView {
    // This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
