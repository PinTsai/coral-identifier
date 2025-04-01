//
//  VideoData.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/12.
//

import Foundation
import SwiftData
/// A SwiftData model representing a video entry in the app.
/// Attributes:
/// The URL of the video file, stored externally.
/// A unique identifier for the video entry.
/// The title of the video.
@Model
class Video: Identifiable {
    @Attribute(.externalStorage) var videoURL :URL?
    var id: String
    var title: String
    /// Initializes a new Video instance.
    /// - Parameters:
    ///   - videoURL: The URL of the video file.
    ///   - title: The title of the video.
    init(videoURL: URL? = nil, title: String) {
        self.videoURL = videoURL
        self.id = UUID().uuidString
        self.title = title
    }
    
}
