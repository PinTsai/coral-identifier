//
//  ExploreScreen.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//

import SwiftUI
/// A view for exploring educational content about corals.
///
/// `ExploreView` presents various types of educational content including:
/// - Articles
/// - Videos
/// - Quizzes
struct ExploreView: View {
    var body: some View {
       
            ZStack {
                Color(red: 0.61, green: 0.7, blue: 0.77)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(spacing: 15){
                    Text("Explore the Knowledge")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 35))
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    ScrollView {
                        CurvedSectionLayout(cornerRadius: 20, spacing: 0) {
                            ArticleSection()
                            VideoSection()
                            QuizSection()
                            
                    }
                    .frame(minHeight: 700)
                    }
                }
                .background(Color(red: 0.61, green: 0.7, blue: 0.77))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            }
    }
}


#Preview {
    ExploreView()
}

