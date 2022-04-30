//
//  Trailer.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 03/04/21.
//

import Foundation

struct Trailer: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var videoURL: URL
    var thumbnailURL: URL
}

let exampleVideoURL = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!
let exampleThumbnailURL = URL(string: "https://picsum.photos/400/400")!

let exampleTrailer = Trailer(
    name: "Trailer Example",
    videoURL: exampleVideoURL,
    thumbnailURL: exampleThumbnailURL
)
