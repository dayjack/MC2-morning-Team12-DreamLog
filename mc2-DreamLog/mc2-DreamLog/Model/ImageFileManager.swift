//
//  ImageFileManager.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/12.
//

import Foundation
import SwiftUI

class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()
    // Save Image
    // name: ImageName
    func saveImage(image: UIImage, name: String,
                   onSuccess: @escaping ((Bool) -> Void)) {
        guard let data: Data
                = image.jpegData(compressionQuality: 1)
                ?? image.pngData() else { return }
        if let directory: NSURL =
            // MARK: - url 수정
            try? FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")! as NSURL {
            do {
                try data.write(to: directory.appendingPathComponent(name)!)
                onSuccess(true)
            } catch let error as NSError {
                print("Could not saveImage🥺: \(error), \(error.userInfo)")
                onSuccess(false)
            }
        }
    }
    
    
    // named: 저장할 때 지정했던 uniqueFileName
    func getSavedImage(named: String) -> UIImage? {
        // MARK: - url 수정
        if let dir: URL
            = try? FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")! {
            let path: String
            = URL(fileURLWithPath: dir.absoluteString)
                .appendingPathComponent(named).path
            let image: UIImage? = UIImage(contentsOfFile: path)
            
            return image
        }
        return nil
    }
}
