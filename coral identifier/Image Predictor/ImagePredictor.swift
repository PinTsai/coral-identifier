//
//  ImagePredictor.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/10.
//

import Vision
import UIKit

/// Handles image classification using Vision and Core ML.
class ImagePredictor {
    /// Creates and returns a VNCoreMLModel for image classification.
    /// - Returns: A VNCoreMLModel instance configured for coral classification.
    static func createImageClassifier() -> VNCoreMLModel {
        let defaultConfig = MLModelConfiguration()
        
        let imageClassifierWrapper = try? CoralClassifier(configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        
        let imageClassifierModel = imageClassifier.model
        
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        return imageClassifierVisionModel
    }
    
    private static let imageClassifier = createImageClassifier()
    
    /// Represents a single prediction from the image classifier.
    struct Prediction {
        let classification: String
        let confidencePercentage: String
    }
    /// Creates a VNCoreMLRequest for image classification.
    /// - Returns: A VNImageBasedRequest configured for coral classification.
    private func createImageClassificationRequest() -> VNImageBasedRequest {
        let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.imageClassifier)
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }
    /// Performs image classification on the given photo.
    /// - Parameter photo: The UIImage to be classified.
    /// - Returns: An array of Prediction objects representing the classification results.
    /// - Throws: An error if the classification process fails.
    func makePredictions(for photo: UIImage) async throws -> [Prediction] {
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)

        guard let photoImage = photo.cgImage else {
            throw NSError(domain: "ImagePredictor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Photo doesn't have underlying CGImage."])
        }

        let imageClassificationRequest = createImageClassificationRequest()
        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        
        try handler.perform([imageClassificationRequest])
        
        guard let observations = imageClassificationRequest.results as? [VNClassificationObservation] else {
            throw NSError(domain: "ImagePredictor", code: 1, userInfo: [NSLocalizedDescriptionKey: "VNRequest produced the wrong result type."])
        }
        
        let predictions = observations.map { observation in
            Prediction(classification: observation.identifier,
                       confidencePercentage: observation.confidencePercentageString)
        }
        
        return predictions
    }
}
