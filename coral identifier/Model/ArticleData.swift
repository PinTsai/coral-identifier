//
//  ArticleData.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//

import Foundation
import SwiftData
/// A SwiftData model representing an article in the app.
/// Attributes:
/// A unique identifier for the article.
/// The title of the article.
/// The content of the article.
@Model
class Article: Identifiable {
    var id: String
    var title: String
    var content: String
    
    /// Initializes a new Article instance.
    /// - Parameters:
    ///   - title: The title of the article.
    ///   - content: The content of the article.
    init(title: String, content: String) {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
    }
    
}
