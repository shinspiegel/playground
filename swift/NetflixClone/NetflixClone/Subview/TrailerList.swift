//
//  TrailerList.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 03/04/21.
//

import SwiftUI

struct TrailerList: View {
    var trailers: [Trailer]

    var body: some View {
        VStack {
            ForEach(trailers) { trailer in
                VStack(alignment: .leading) {
                    PreviewVideoPlayer(
                        imageURL: trailer.thumbnailURL,
                        videoURL: trailer.videoURL
                    )
                    .frame(width: PhoneDetails.screen.width, height: 250, alignment: .center)
                    .clipped()

                    Text(trailer.name)
                        .font(.headline)
                }
                .padding(.bottom, 20)
            }
        }
        .foregroundColor(.white)
    }
}

struct TrailerList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            TrailerList(trailers: [exampleTrailer, exampleTrailer, exampleTrailer, exampleTrailer])
        }
    }
}
