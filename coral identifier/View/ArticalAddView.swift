//
//  ArticalAddView.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/3.
//

import SwiftUI
import SwiftData
/// A view for adding new articles to the app.
struct ArticleAddView: View {
    @Environment(\.modelContext) private var context
    @Query private var articles:[Article]
    
    @State private var titleInput = ""
    @State private var contentInput = ""
    @FocusState private var focus: FormFieldFocus?
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.7, blue: 0.77)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack {
                    Text("Title:")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                    .foregroundColor(.black)
                    .frame(width: 100, height: 30, alignment: .topLeading)
                    .offset(x:-125, y:15)
            
                    
                    TextField("Enter the title...", text: $titleInput)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(Color(red: 0.85, green: 0.85, blue: 0.85))))
                        .padding(15)
                        .onSubmit {
                            focus = .content
                        }
                        .focused($focus, equals: .title)
                    
                    Spacer(minLength: -10)
                    
                    Text("Content:")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                    .foregroundColor(.black)
                    .frame(width: 100, height: 30, alignment: .topLeading)
                    .offset(x:-125, y:15)

                    
                    TextEditor(text: $contentInput)
                        .frame(height: 400)
                        .padding()
                        .scrollContentBackground(.hidden)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(Color(red: 0.85, green: 0.85, blue: 0.85))))
                        .padding(15)
                        .focused($focus, equals: .content)
                    
                    Spacer(minLength: -10)

                    Button("Save") {
                        let titleIsValid = !titleInput.isEmpty
                        let contentIsValid = !contentInput.isEmpty
                        if titleIsValid && contentIsValid {
                            print("Saving post: \(titleInput)")
                            print("Content: \(contentInput)")
                            addArticle()
                        } else if titleIsValid {
                            focus = .content
                        } else {
                            focus = .title
                        }
                    }
                    .buttonStyle(GrowingButton())
                    .frame(width: 100, height: 30, alignment: .topLeading)
                    .offset(x:160, y:15)
                    

                .onAppear {
                    focus = .title
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color(Color(red: 0.61, green: 0.7, blue: 0.77)))
            }
        }
    }
    enum FormFieldFocus: Hashable {
        case title, content
        }
        
    /// Adds a new article to the database.
    ///
    /// This function creates a new Article object with the provided
    /// title and content, then inserts it into the database.
    func addArticle() {
        let article = Article(title: titleInput, content: contentInput)
        context.insert(article)
    }
}


#Preview {
    ArticleAddView()
}

