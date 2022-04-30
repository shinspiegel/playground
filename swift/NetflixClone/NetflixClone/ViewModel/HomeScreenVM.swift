//
//  HomeScreenVM.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import Foundation

class HomeScreenVM: ObservableObject {
    @Published var movies: [String: [Movie]] = [:]
    
    init() {
        setupMovies()
    }

    func setupMovies() {
        movies["Trending Now"] = [
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
        ]
        
        movies["Horror Movies"] = [
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
        ]
        
        movies["Sci-fi Shows"] = [
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
            ExempleMovie,
        ]
    }
    
    public var topVideo: Movie {
        return movies["Trending Now"]![0]
    }
    
    public var allCategories: [String] {
        return movies.keys.map { String($0) }
    }
    
    public func getMovies(_ category: String) -> [Movie] {
        return movies[category] ?? []
    }
}
