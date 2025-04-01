//
//  ContentView.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/28.
//

import SwiftUI

/// A view that serves as the main container for the Coral Identifier app.
///
/// `ContentView` manages the overall structure of the app, including:
/// - The main navigation view
/// - Tab-based navigation between different sections of the app
/// - Presentation of the classification result
///
/// It uses a custom tab bar and manages the state for showing different views based on user selection.
struct ContentView: View {
    @State var selectedTab = 0
    @State var showResultScreen: Bool = false
    @StateObject private var imageProcessingManager = ImageProcessingManager()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 0.61, green: 0.7, blue: 0.77)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                // Content based on selected tab
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    MyCorals()
                case 2:
                    ExploreView()
                case 3:
                    MoreView()
                default:
                    HomeView()
                }
                /// A custom tab bar for navigation.
                CustomTabs(index: $selectedTab, imageProcessingManager: imageProcessingManager)
                    .frame(width: 400, height: 700, alignment: .bottom)
                    .offset(x:0, y:50)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            /// A view displaying the results of coral classification.
            .sheet(isPresented: $imageProcessingManager.showResult) {
                ClassificationResultView(imageProcessingManager: imageProcessingManager)
            }
        }
    }
}
   

#Preview {
    ContentView()
}
