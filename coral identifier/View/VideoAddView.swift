//
//  VideoAddView.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/12.
//

import SwiftData
import SwiftUI

/// A view for adding new video content to the app.
/// Contain the input fields for the video URL and video title
struct VideoAddView: View {
    @Environment(\.modelContext) private var context
    @Query private var videos:[Video]
    
    @State private var UrlInput = ""
    @State private var titleInput = ""
    @FocusState private var focus: FormFieldFocus?
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.7, blue: 0.77)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack {
                    Text("Video URL:")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                    .foregroundColor(.black)
                    .frame(width: 150, height: 30, alignment: .topLeading)
                    .offset(x:-100, y:15)
            
                    
                    TextField("Enter the video URL...", text: $UrlInput)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(Color(red: 0.85, green: 0.85, blue: 0.85))))
                        .padding(15)
                        .onSubmit {
                            focus = .title
                        }
                        .focused($focus, equals: .url)
                    
                    Spacer(minLength: -10)
                    
                    Text("Title:")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                    .foregroundColor(.black)
                    .frame(width: 150, height: 30, alignment: .topLeading)
                    .offset(x:-100, y:15)
            
                    
                    TextField("Enter the title...", text: $titleInput)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(Color(red: 0.85, green: 0.85, blue: 0.85))))
                        .padding(15)
                        .focused($focus, equals: .title)
                    
                    Spacer(minLength: -10)

                    Button("Save") {
                        let urlIsValid = !UrlInput.isEmpty
                        let titleIsValid = !titleInput.isEmpty
                        if urlIsValid && titleIsValid {
                            print("Saving video: \(UrlInput)")
                            print("Title: \(titleInput)")
                            addVideo()
                        } else if urlIsValid {
                            focus = .title
                        } else {
                            focus = .url
                        }
                    }
                    .buttonStyle(GrowingButton())
                    .frame(width: 100, height: 30, alignment: .topLeading)
                    .offset(x:160, y:15)
                    

                .onAppear {
                    focus = .url
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color(Color(red: 0.61, green: 0.7, blue: 0.77)))
            }
        }
    }
    enum FormFieldFocus: Hashable {
        case url, title
        }
        
    /// Adds a new video to the database.
    ///
    /// This function validates the URL and creates a new Video object
    /// with the provided URL and title.
    func addVideo() {
        guard let url = URL(string: UrlInput), UIApplication.shared.canOpenURL(url) else {
                print("Invalid URL")
                return
            }
        let video = Video(videoURL: url, title: titleInput)
        context.insert(video)
    }
}


#Preview {
    VideoAddView()
}
