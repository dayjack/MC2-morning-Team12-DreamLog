//
//  ShareSheet.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/09.
//

import Foundation
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        // Create the activity view controller with the activity items to share
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // Set the excluded activity types, if any
        controller.excludedActivityTypes = [.addToReadingList, .airDrop]
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {
        // Not needed
    }
}
