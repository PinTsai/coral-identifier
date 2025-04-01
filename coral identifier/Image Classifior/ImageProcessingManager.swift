//
//  ImageClassify.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/10.
//

import Foundation
import SwiftUI
import Vision
/// Manages the image processing and classification workflow.
class ImageProcessingManager: ObservableObject {
    private let imagePredictor = ImagePredictor()
    @Published var predictions: [ImagePredictor.Prediction]?
    @Published var isProcessing = false
    @Published var showResult: Bool = false
    @Published var topPrediction: ImagePredictor.Prediction?
    @Published var selectedImage: UIImage?

    /// Processes the given image and updates the prediction results.
    /// - Parameter image: The UIImage to be processed and classified.
    func processImage(_ image: UIImage?) async {
        guard let selectedImage = image else { return }
        
        await MainActor.run {
            self.isProcessing = true
            self.selectedImage = selectedImage
        }
        
        do {
            let predictions = try await imagePredictor.makePredictions(for: selectedImage)
            
            await MainActor.run {
                self.predictions = predictions
                self.isProcessing = false
                
                if let topPrediction = predictions.first {
                    print("Top prediction: \(topPrediction.classification) with confidence \(topPrediction.confidencePercentage)")
                    self.topPrediction = topPrediction
                    self.showResult = true
                    print("showResult set to true, current value: \(self.showResult)")
                }
            }
        } catch {
            print("Failed to make predictions: \(error)")
            await MainActor.run { self.isProcessing = false }
        }
    }
}
