//
//  MoreLikeThis.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 03/04/21.
//

import SwiftUI

struct MoreLikeThis: View {
    var movies: [Movie]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, content: {
                ForEach(0 ..< movies.count) { index in
                    StandardMovie(movie: movies[index])
                }
            })
        }.foregroundColor(.white)
    }
}

struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            MoreLikeThis(movies: [
                ExempleMovie,
                ExempleMovie,
                ExempleMovie,
                ExempleMovie,
                ExempleMovie,
                ExempleMovie,
            ])
        }
    }
}
