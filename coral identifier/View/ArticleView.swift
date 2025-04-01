//
//  ArticleView.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/4.
//

import SwiftUI
import SwiftData

/// A view that displays a list of all articles.
struct ArticleView: View {
    @Query private var articles:[Article]
    
    var body: some View {
        VStack{
            Text("Article")
                .font(Font.custom("RopaSans-Italic", fixedSize: 35))
                .foregroundColor(.black)
            
            List(articles){ Article in
                Text(Article.title)
            }   
        }
    }
}

#Preview {
    ArticleView()
}
