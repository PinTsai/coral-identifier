//
//  VideoSection.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//
import SwiftData
import SwiftUI
import AVKit

/// A view that displays a horizontal scrollable list of videos.
struct VideoSection: View {
    @Query private var videos:[Video]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Video")
                .font(Font.custom("RopaSans-Italic", fixedSize: 20))
                .foregroundColor(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(videos) { video in
                        NavigationLink(destination: VideoView(video: video)) {
                            VideoGroupView(video: video)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}
/// A view representing a single video in the horizontal scroll view.
struct VideoGroupView: View {
    let video: Video
    @State private var thumbnail: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let thumbnail = thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 160, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Text(video.title)
                .foregroundColor(.black)
                .font(Font.custom("RopaSans-Italic", size: 15))
                .lineLimit(nil)
                .padding(.leading, 0)
        }
        .frame(width: 200, height: 150)
        .onAppear(perform: loadThumbnail)
    }
    /// Loads the thumbnail image for the video.
    ///
    /// This function attempts to generate a thumbnail from the video's first frame.
    private func loadThumbnail() {
            guard let url = video.videoURL else { return }
            
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            do {
                let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
                thumbnail = UIImage(cgImage: cgImage)
            } catch {
                print("Error generating thumbnail: \(error)")
            }
        }
    }
/// A view for playing a selected video.
/// Implement the AVPlayer instance for video playback.
struct VideoView: View {
    let video: Video
    @State private var player: AVPlayer?
    @State private var errorMessage: String?
    
    var body: some View {
        Group {
            if let player = player {
                VideoPlayer(player: player)
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: loadVideo)
    }
    /// Loads and prepares the video for playback.
    ///
    /// This function attempts to create an AVPlayer instance from the video's URL.
    /// If successful, it assigns the player to the `player` state variable.
    /// If unsuccessful, it sets an appropriate error message.
    private func loadVideo() {
        guard let url = video.videoURL else {
            errorMessage = "Invalid video URL"
            return
        }
        
        let asset = AVAsset(url: url)
        asset.loadTracks(withMediaType: .video) { tracks, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = "Error loading video: \(error.localizedDescription)"
                } else if tracks?.isEmpty ?? true {
                    errorMessage = "No video track found"
                } else {
                    player = AVPlayer(url: url)
                }
            }
        }
    }
}


#Preview {
    VideoSection()
}
