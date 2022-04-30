//
//  Episode.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 28/03/21.
//

import Foundation

struct Episode: Identifiable {
    var id = UUID().uuidString
    var name: String
    var episodeNumber: Int
    var season: Int

    var thumbnailURLString: String
    var videoURLString: String

    var description: String
    var lenght: Int

    var videoURL: URL { return URL(string: videoURLString)! }
    var thumbnailURL: URL { return URL(string: thumbnailURLString)! }
}

let ExempleEpisode = Episode(
    name: "First Episode",
    episodeNumber: 1,
    season: 1,
    thumbnailURLString: "https://picsum.photos/300/300",
    videoURLString: "https://filesamples.com/samples/video/mp4/sample_960x400_ocean_with_audio.mp4",
    description: "This is a very long description to be used on the video details for the screen I'm creating on the Netflix clone using swiftUI",
    lenght: 47
)
