//
//  ImagePicker.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//

import Foundation
import SwiftUI
/// A SwiftUI view that wraps UIImagePickerController for selecting images from the camera or photo library.
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    @Binding var isNewImageSelected: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    /// Creates and returns a UIImagePickerController configured with the specified source type.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    /// Updates the presented UIImagePickerController (not used in this implementation).
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    /// Creates and returns a Coordinator to act as the delegate for the UIImagePickerController.
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    /// A coordinator class that acts as the delegate for the UIImagePickerController.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        /// Called when the user finishes picking an image.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
                parent.isNewImageSelected = true
            }
            parent.isShown = false
        }
        /// Called when the user cancels image selection.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
            parent.isNewImageSelected = false
        }
    }
}
