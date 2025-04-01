//
//  MyCorals.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/30.
//

import SwiftUI
import SwiftData

/// A view displaying the user's saved coral identifications.
///
/// `MyCorals` features:
/// - A search bar for filtering corals
/// - A grid layout of saved coral images and their classification
/// - Functionality to delete saved corals
struct MyCorals: View {
    
    @State private var searchText = ""
    @Query private var corals:[Coral]

    var body: some View {
        VStack(spacing: 20) {
            Text("My Corals")
                .font(Font.custom("RopaSans-Italic", fixedSize: 35))
                .foregroundColor(.black)
            
            SearchBar(text: $searchText)
            
            HStack{
                Text("All corals")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 15))
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image("Sort icon")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("Sort")
                        .font(Font.custom("RopaSans-Italic", fixedSize: 15))
                        .foregroundColor(.black)
                }
                
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(corals.filter {
                        searchText.isEmpty ? true : $0.classificationResult.localizedCaseInsensitiveContains(searchText)
                    }) { coral in
                        CoralItem(coral: coral)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(Color(red: 0.85, green: 0.9, blue: 0.95)))
    }
}

/// A custom search bar for filtering corals.
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search My Corals...", text: $text)
        }
        .padding(10)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

/// A view representing a single coral item in the grid.
struct CoralItem: View {
    let coral: Coral
    @State private var image: UIImage?
    @State private var isLongPressed = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .overlay(
                        Text("No Image")
                            .foregroundColor(.white)
                    )
            }
            Text(coral.classificationResult)
                .font(Font.custom("RopaSans-Italic", fixedSize: 15))
                .foregroundColor(.black)
        }
        .onAppear {
            loadImage()
        }
        .gesture(
            LongPressGesture(minimumDuration: 1)
                .onChanged { _ in
                    isLongPressed = true
                }
                .onEnded { _ in
                    isLongPressed = false
                    deleteCoral()
                }
        )

    }
    /// Loads the coral's image from the saved path.
    private func loadImage() {
        if let imagePath = coral.imagePath {
            self.image = ImageManager.shared.loadImage(fromPath: imagePath)
        }
    }
    /// Deletes the coral from both storage and the database.
    private func deleteCoral() {
            // Delete the image file
            if let imagePath = coral.imagePath {
                ImageManager.shared.deleteImage(atPath: imagePath)
            }
            
            // Delete the coral from SwiftData
            modelContext.delete(coral)
            
            // Save the changes
            do {
                try modelContext.save()
            } catch {
                print("Error deleting coral: \(error)")
            }
        }
}

#Preview {
    MyCorals()
}
