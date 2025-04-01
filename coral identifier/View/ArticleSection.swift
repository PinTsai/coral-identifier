//
//  ArticleSection.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//

import SwiftUI
import SwiftData

/// A view that displays a horizontal scrollable list of articles.
struct ArticleSection: View {
    @Query private var articles:[Article]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Article")
                .font(Font.custom("RopaSans-Italic", fixedSize: 20))
                .foregroundColor(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleGroupView(article: article)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(red: 0.87, green: 0.85, blue: 0.91))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}
/// A view representing a single article in the horizontal scroll view.
struct ArticleGroupView: View{
    let article: Article
    
    var body: some View {
        VStack (alignment: .leading) {
            Image("Coral_1")
                .resizable()
                .frame(width: 160, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(article.title)
                .foregroundColor(.black)
                .font(Font.custom("RopaSans-Italic",size: 15))
                .lineLimit(nil)
                .padding(.leading, 0)
        }
        .frame(width: 200, height: 150)
    }
}
/// A view displaying the full details of an article.
struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.7, blue: 0.77)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack{
                    Text(article.title)
                        .font(Font.custom("RopaSans-Italic", fixedSize: 30))
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 10)
                    
                    Text(article.content)
                        .padding(10)
                        .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                        .foregroundColor(.black)
                }
            }
        }
    }
}


#Preview {
    ArticleSection()
//        .modelContainer(for: Article.self, inMemory: true)
}
