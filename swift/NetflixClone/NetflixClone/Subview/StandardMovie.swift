//
//  StandardMovie.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import KingfisherSwiftUI
import SwiftUI

struct StandardMovie: View {
    var movie: Movie

    var body: some View {
        KFImage(movie.thumbnail)
            .resizable()
            .scaledToFill()
    }
}

struct StandardMovie_Previews: PreviewProvider {
    static var previews: some View {
        StandardMovie(movie: ExempleMovie)
            .frame(width: 200, height: 300)
            .previewLayout(.sizeThatFits)
    }
}
