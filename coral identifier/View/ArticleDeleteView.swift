//
//  ArticleDeleteView.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/12.
//

import SwiftUI
import SwiftData
/// A view that allows users to delete articles.
struct ArticleDeleteView: View {
    @Environment(\.modelContext) private var context
    @Query private var articles:[Article]
    
    var body: some View {
        VStack{
            Text("Swipe to delete the article")
                .font(Font.custom("RopaSans-Italic", fixedSize: 20))
                .foregroundColor(.black)
            
            List{
                ForEach(articles) { article in
                    Text(article.title)
                }
                .onDelete { indexes in
                    for index in indexes{
                        deleteArticle(articles[index])
                    }
                }
            }
        }
        .padding()
    }
    
    /// Deletes the specified article from the database.
    /// - Parameter article: The Article object to delete.
    func deleteArticle(_ article: Article) {
        context.delete(article)
    }
}

#Preview {
    ArticleDeleteView()
}
