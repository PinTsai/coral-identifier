//
//  HomeView.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//


import SwiftUI

/// A view representing the home screen of the Coral Identifier app.
///
/// `HomeView` displays:
/// - A welcome message
/// - Current weather information
struct HomeView: View {
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.7, blue: 0.77)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 10) {
                Text("Home")
                .font(Font.custom("RopaSans-Italic", fixedSize: 35))
                .foregroundColor(.black)
                .padding(.bottom, 10)
                                
                WeatherView()
                    .padding(.bottom, 100)
                
                HStack(spacing:-5){
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding()
                
                    
                    VStack (alignment: .leading){
                        Text("G'day, Coral Lover!")
                        .font(Font.custom("RopaSans-Italic", fixedSize: 30))
                        .foregroundColor(.black)
                        
                        Text("Tap here to edit personal detail")
                        .font(Font.custom("RopaSans-Regular", fixedSize: 15))
                        .foregroundColor(.gray)
                    }
                    
                }
                Spacer()
            }
            .background(Color(red: 0.61, green: 0.7, blue: 0.77))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }

    }
}


    #Preview {
        HomeView()
    }
