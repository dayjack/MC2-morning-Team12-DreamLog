//
//  UIApplication.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/15.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
