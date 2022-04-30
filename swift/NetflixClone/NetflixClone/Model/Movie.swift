//
//  Movie.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import Foundation

struct Movie: Identifiable {
    // GENERAL
    var id: String = UUID().uuidString
    var name: String
    var thumbnail: URL
    var categories: [String]

    // MOVIE Details
    var year: Int
    var rating: String
    var isHD: Bool
    var cast: [String]
    var creators: [String]
    var promotionHeadline: String?
    var moveLikeThis: [Movie]
    var trailers: [Trailer]

    // SHOW Details
    var numberOfSeaons: Int?
    var episodes: [Episode]?

    var defaultEpisodeInfo: ShowInfo
    var currentEpisodeInfo: ShowInfo?

    var numberOfSeasonsDisplay: String {
        if let num = numberOfSeaons {
            if num == 1 {
                return "1 season"
            } else {
                return "\(num) seasons"
            }
        }
        return ""
    }
}

struct ShowInfo: Hashable, Equatable {
    var episodeName: String
    var description: String
    var season: Int
    var episode: Int
}

let ExampleDefaultEpisodeInfo = ShowInfo(
    episodeName: "Default",
    description: "This is a default description that shows something to the user.",
    season: 0,
    episode: 0
)

let ExampleCurrentEpisodeInfo = ShowInfo(
    episodeName: "This is a custom Episode Info",
    description: "This is a message designer to show to a specific user related to the episode and seasons showing",
    season: 2,
    episode: 3
)

let MovieForList = Movie(
    id: UUID().uuidString,
    name: "Dark",
    thumbnail: URL(string: "https://picsum.photos/200/300")!,
    categories: ["Sci-fy", "Terror", "Gezus"],

    year: 2020,
    rating: "TV-MA",
    isHD: true,
    cast: ["Shin", "Lerry", "Arthur"],
    creators: ["Martin", "Lucas"],
    promotionHeadline: "Watch season 3 now!",
    moveLikeThis: [],
    trailers: [],
    numberOfSeaons: 1,
    episodes: [
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode
    ],

    defaultEpisodeInfo: ExampleDefaultEpisodeInfo,
    currentEpisodeInfo: ExampleCurrentEpisodeInfo
)

let ExempleMovie = Movie(
    id: UUID().uuidString,
    name: "Dark",
    thumbnail: URL(string: "https://picsum.photos/200/300")!,
    categories: ["Sci-fy", "Terror", "Gezus"],

    year: 2020,
    rating: "TV-MA",
    isHD: true,
    cast: ["Shin", "Lerry", "Arthur"],
    creators: ["Martin", "Lucas"],
    promotionHeadline: "Watch season 3 now!",
    moveLikeThis: [MovieForList, MovieForList, MovieForList, MovieForList, MovieForList, MovieForList],
    trailers: [exampleTrailer, exampleTrailer, exampleTrailer, exampleTrailer, exampleTrailer],
    numberOfSeaons: 1,
    episodes: [
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode,
        ExempleEpisode
    ],

    defaultEpisodeInfo: ExampleDefaultEpisodeInfo,
    currentEpisodeInfo: ExampleCurrentEpisodeInfo
)
