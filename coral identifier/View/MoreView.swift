//
//  MoreView.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//

import SwiftUI
/// A view for managing and editing educational content in the app.
///
/// `MoreView` provides options to:
/// - Add, update, or delete articles
/// - Add or delete videos
/// - Add, update, or delete quizzes
struct MoreView: View {
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.7, blue: 0.77)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            VStack(spacing:30){
                
                Text("Knowledge Edit")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 35))
                    .foregroundColor(.black)
                
                
                // Article Section Edit options
                VStack {
                    
                    Text("Article Section:")
                        .font(Font.custom("RopaSans-Regular", fixedSize: 25))
                        .foregroundColor(.black)
                    
                    HStack{
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "doc.fill.badge.plus")
                                        .foregroundColor(.white)
                                    
                                    Text("Add Article")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                        
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                    Text("Update Article")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                        
                        NavigationLink(
                            destination: ArticleDeleteView(),
                            label:{
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.white)
                                    Text("Delete Article")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                    }
                }
                
                
                
                VStack {
                    Text("Video Section:")
                        .font(Font.custom("RopaSans-Regular", fixedSize: 25))
                        .foregroundColor(.black)
                        .padding()
                    
                    HStack{
                        NavigationLink(
                            destination: VideoAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "doc.fill.badge.plus")
                                        .foregroundColor(.white)
                                    Text("Add Video")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                        
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.white)
                                    Text("Delete Video")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                    }
                }
                
                
                VStack {
                    Text("Quiz Section:")
                        .font(Font.custom("RopaSans-Regular", fixedSize: 25))
                        .foregroundColor(.black)
                        .padding()
                    
                    HStack{
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "doc.fill.badge.plus")
                                        .foregroundColor(.white)
                                    Text("Add    Quiz")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                        
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                    Text("Update Quiz")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                        
                        NavigationLink(
                            destination: ArticleAddView(),
                            label:{
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.white)
                                    Text("Delete Quiz")
                                        .foregroundColor(.black)
                                        .font(Font.custom("RopaSans-Regular", fixedSize: 20))
                                }
                            })
                        .frame(width: 100, height: 70)
                        .background(Color(Color(red: 0.96, green: 0.84, blue: 0.73)))
                        .clipShape(Capsule())
                    }
                }
                
                
                Spacer()
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color(Color(red: 0.61, green: 0.7, blue: 0.77)))
            
        }
    }
    
    
}




#Preview {
    MoreView()
}
