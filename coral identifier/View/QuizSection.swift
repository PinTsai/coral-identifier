//
//  QuizSection.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//

import SwiftUI
/// A view that represents the quiz section of the app.
///
/// Currently, this is a placeholder view indicating that the quiz feature is coming soon.
struct QuizSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Quiz (Coming soon...)")
                .font(Font.custom("RopaSans-Italic", fixedSize: 20))
                .foregroundColor(.black)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 150, height: 130)
                    }
                }
            }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}

#Preview {
    QuizSection()
}
