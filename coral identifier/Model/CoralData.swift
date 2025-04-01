//
//  CoralImage.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//

import Foundation
import SwiftUI
import SwiftData
/// A SwiftData model representing a coral identification entry.
/// - Attributes
/// unique identifier for the coral entry.
/// The file path of the saved coral image, if any.
/// The result of the coral classification.
@Model
class Coral {
    var id: UUID
    var imagePath: String?
    var classificationResult: String
    
    /// Initializes a new Coral instance.
    /// - Parameters:
    ///   - imagePath: The file path of the saved coral image.
    ///   - classificationResult: The result of the coral classification.
    init(imagePath: String?, classificationResult: String) {
            self.id = UUID()
            self.imagePath = imagePath
            self.classificationResult = classificationResult
        }
    
}

