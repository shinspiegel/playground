//
//  VideoPlayer.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 03/04/21.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: View {
    var url: URL

    private var avPlayer: AVPlayer {
        return AVPlayer(url: url)
    }

    var body: some View {
        VideoPlayer(player: avPlayer)
    }
}

struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoPlayer(url: exampleVideoURL)
    }
}
