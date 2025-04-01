//
//  ImageSaveManager.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/13.
//

import Foundation
import UIKit

/// A singleton class for managing image-related operations.
class ImageManager {
    static let shared = ImageManager()
    
    private init() {}

    /// Saves an image to the documents directory.
    /// - Parameters:
    ///   - image: The UIImage to save.
    ///   - coralId: The UUID of the associated coral entry.
    /// - Returns: The file path of the saved image, or nil if saving failed.
    func saveImage(_ image: UIImage, forCoral coralId: UUID) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        let filename = coralId.uuidString + ".jpg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    /// Loads an image from a given file path.
    /// - Parameter path: The file path of the image to load.
    /// - Returns: The loaded UIImage, or nil if loading failed.
    func loadImage(fromPath path: String) -> UIImage? {
        return UIImage(contentsOfFile: path)
    }
    /// Returns the URL of the app's documents directory.
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    /// Deletes an image file at the specified path.
    /// - Parameter path: The file path of the image to delete.
    func deleteImage(atPath path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print("Error deleting image file: \(error)")
        }
    }
}
