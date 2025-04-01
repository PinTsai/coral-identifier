//
//  ClassificationResultView.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/10.
//

import SwiftUI
import SwiftData
/// A view displaying the result of coral classification.
///
/// This view shows:
/// - The image of the coral
/// - The top prediction for the coral's classification
/// - The confidence level of the prediction
/// - Options to save or discard the classification
struct ClassificationResultView: View {
    @ObservedObject var imageProcessingManager: ImageProcessingManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSaveAlert = false
    @State private var saveAlertMessage = ""
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    if let image = imageProcessingManager.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    if let topPrediction = imageProcessingManager.topPrediction {
                        Text("Top prediction: \(topPrediction.classification)")
                            .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Text("Confidence: \(topPrediction.confidencePercentage)")
                            .font(Font.custom("RopaSans-Italic", fixedSize: 25))
                            .foregroundColor(.black)
                            .padding(.bottom)
                    } else {
                        Text("No prediction available")
                            .font(.title2)
                            .padding()
                    }
                    
                    HStack {
                        
                        Button("Save") {
                            saveCoral()
                            imageProcessingManager.showResult = false
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(GrowingButton())
                        .frame(width: 100, height: 30)
                        .padding()
                        
                        Button("Close") {
                            imageProcessingManager.showResult = false
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(GrowingButton())
                        .frame(width: 100, height: 30)
                        .padding()
                        
                    }
                }
                .padding()
                .alert(isPresented: $showingSaveAlert) {
                                Alert(title: Text("Save Coral"), message: Text(saveAlertMessage), dismissButton: .default(Text("OK")))
                            }
            }
        }
    }
    /// Saves the classified coral to the database and local storage.
        ///
        /// This function:
        /// 1. Creates a new Coral object
        /// 2. Saves the coral image to local storage
        /// 3. Inserts the new Coral into the SwiftData context
        /// 4. Displays an alert with the result of the save operation
    private func saveCoral() {
            guard let image = imageProcessingManager.selectedImage,
                  let topPrediction = imageProcessingManager.topPrediction else {
                saveAlertMessage = "Error: No image or prediction available"
                showingSaveAlert = true
                return
            }
            
            let newCoral = Coral(imagePath: nil,
                                 classificationResult: topPrediction.classification)
            
            if let imagePath = ImageManager.shared.saveImage(image, forCoral: newCoral.id) {
                newCoral.imagePath = imagePath
            } else {
                saveAlertMessage = "Error: Failed to save image"
                showingSaveAlert = true
                return
            }
            
            modelContext.insert(newCoral)
            
            do {
                try modelContext.save()
                saveAlertMessage = "Coral saved successfully"
                showingSaveAlert = true
            } catch {
                saveAlertMessage = "Error saving coral: \(error.localizedDescription)"
                showingSaveAlert = true
            }
        }
    }


