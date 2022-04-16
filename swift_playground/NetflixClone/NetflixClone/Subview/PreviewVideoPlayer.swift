//
//  VideoImagePreview.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 03/04/21.
//

import KingfisherSwiftUI
import SwiftUI

struct PreviewVideoPlayer: View {
    @State private var isOpened = false

    var imageURL: URL
    var videoURL: URL

    var body: some View {
        ZStack {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)

            Button(action: {
                isOpened = true
            }, label: {
                Image(systemName: "play.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
            })
                .sheet(isPresented: $isOpened, content: {
                    CustomVideoPlayer(url: videoURL)
                })
        }
    }
}

struct PreviewVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        PreviewVideoPlayer(imageURL: exampleThumbnailURL, videoURL: exampleVideoURL)
    }
}
