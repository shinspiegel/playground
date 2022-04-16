//
//  EpisodesView.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 07/04/21.
//

import SwiftUI

struct EpisodesView: View {
    var episodes: [Episode]

    @Binding var showSeasonPicker: Bool
    @Binding var selectedSeason: Int

    func getEpisodes(forSeason season: Int) -> [Episode] {
        return episodes.filter { $0.season == season }
    }

    var body: some View {
        VStack(spacing: 12) {
            // Season Picker
            HStack {
                Button(action: {
                    showSeasonPicker = true
                }, label: {
                    Group {
                        Text("Season 1")
                        Image(systemName: "chevron.down")
                            .font(.system(size: 16))
                    }
                })

                Spacer()
            }

            ForEach(getEpisodes(forSeason: selectedSeason)) { episode in
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        PreviewVideoPlayer(imageURL: episode.thumbnailURL, videoURL: episode.videoURL)
                            .frame(width: 120, height: 70)
                            .clipped()

                        Group {
                            VStack(alignment: .leading) {
                                Text("\(episode.episodeNumber). \(episode.name)")
                                Text("\(episode.lenght)m")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Image(systemName: "arrow.down.to.line.alt")
                                .font(.system(size: 22))
                                .padding(.trailing)
                        }
                        .padding(.top, 8)
                    }

                    Text(episode.description)
                        .font(.system(size: 13))
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 16)
            }
        }
        .foregroundColor(.white)
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            EpisodesView(
                episodes: [ExempleEpisode, ExempleEpisode, ExempleEpisode],
                showSeasonPicker: .constant(false),
                selectedSeason: .constant(1)
            )
        }
    }
}
