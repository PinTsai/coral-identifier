//
//  CustomTabs.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//

import Foundation
import SwiftUI


struct CustomTabs : View {
    
    @Binding var index : Int
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var isNewImageSelected: Bool = false
    @ObservedObject var imageProcessingManager: ImageProcessingManager
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    tabButton(image: "Home", label: "Home", tag: 0)
                    Spacer()
                    tabButton(image: "My corals", label: "MyCorals", tag: 1)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    tabButton(image: "Explore", label: "Knowledge", tag: 2)
                    Spacer()
                    tabButton(image: "More", label: "More", tag: 3)
                    Spacer()
                }
                .padding(.top, 50)
                
                // Camera icon
                .overlay(alignment: .top) {
                    Button {
                        print("Create Button Action")
                        self.showSheet = true
                    } label: {
                        Image("Camera") // "plus_icon"
                            .resizable()
                            .scaledToFit()
                            .padding(2)
                            .frame(width: 93, height: 93)
                    }
                    .padding(9)
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"),
                                    message: Text("Choose"), buttons: [
                                        
                                        .default(Text("Camera")){
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },
                                        .default(Text("Photo Library")){
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },
                                        .cancel()
                                    ])
                    }
                }
                .padding(.bottom, max(8, proxy.safeAreaInsets.bottom))
                .background {
                    TabBarShape()
                        .fill(Color.init(red: 244/255, green: 223/255, blue: 187/255))
                        .shadow(radius: 2)
                        .ignoresSafeArea(edges: .bottom)
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    if isNewImageSelected, let image = self.image {
                        processImage(image)
                    }
                    isNewImageSelected = false
                    }) {
                        ImagePicker(image: $image, isShown: $showImagePicker, isNewImageSelected: $isNewImageSelected, sourceType: sourceType)
                    }
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.15)
    }
    
    private func processImage(_ image: UIImage) {
            Task {
                await imageProcessingManager.processImage(image)
            }
        }
    
    
    func tabButton(image: String, label: String, tag: Int) -> some View {
        Button(action: {
            self.index = tag
        }) {
            VStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text(label)
                    .font(Font.custom("RopaSans-Italic", fixedSize: 15))
            }
        }
        .foregroundColor(self.index == tag ? .black : .gray)
    }
}

#Preview{
    ContentView()
}

