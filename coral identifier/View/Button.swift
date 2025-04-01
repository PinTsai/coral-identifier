//
//  Button.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/4.
//

import SwiftUI
/// A custom button style that grows when pressed.
struct GrowingButton: ButtonStyle {
    /// Creates the body of the button.
    /// - Parameter configuration: The button configuration.
    /// - Returns: A view representing the body of the button.
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(Color(red: 0.91, green: 0.77, blue: 0.73)))
            .clipShape(Capsule())
            .foregroundStyle(.white)
            .font(Font.custom("RopaSans-Italic", fixedSize: 20))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


