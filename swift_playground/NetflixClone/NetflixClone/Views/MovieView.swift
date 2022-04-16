//
//  MovieView.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 28/03/21.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie

    @State private var showSeasonPicker = false
    @State private var selectedSeason = 1
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        StandardMovie(movie: movie)
                            .frame(width: PhoneDetails.screen.width * 0.4, height: PhoneDetails.screen.height * 0.26)
                            .clipped()

                        MovieInfoSubheadline(movie: movie)

                        if let promo = movie.promotionHeadline {
                            Text(promo)
                                .font(.headline)
                                .bold()
                                .padding(.vertical, 6)
                        }

                        BaseButton(text: "Play", icon: "play.fill", foregroundColor: .white, backgroundColor: .red) {
                            // Code!
                        }
                        .padding(.bottom)

                        MovieViewDescription(movie: movie)

                        MovieViewCastInfo(movie: movie)

                        HStack(spacing: 30) {
                            SmallVerticalButton(
                                text: "My List",
                                onImage: "checkmark",
                                offImage: "plus",
                                isOn: true) {
                                    // Code!
                            }

                            SmallVerticalButton(
                                text: "Rate",
                                onImage: "hand.thumbsup.fill",
                                offImage: "hand.thumbsup",
                                isOn: true) {
                                    // Code!
                            }

                            SmallVerticalButton(
                                text: "Share",
                                onImage: "square.and.arrow.up",
                                offImage: "square.and.arrow.up",
                                isOn: true) {
                                    // Code!
                            }

                            Spacer()
                        }
                    }
                    .padding(.top, 50)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(width: PhoneDetails.screen.width, alignment: .center)
                    .background(Color.secondary)

                    CustomTabSwitcher(tabs: [.episodes, .trailer, .more], movie: movie)
                }

                Spacer()
            }

            HStack {
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 28))
                })
            }
            .padding(.top, 40)
            .padding(.horizontal, 22)
        }
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: ExempleMovie)
    }
}

struct MovieInfoSubheadline: View {
    var movie: Movie

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "hand.thumbsup.fill").foregroundColor(.white)
            Text(String(movie.year))
            Text(movie.rating)
                .font(.system(size: 12))
                .lineLimit(1)
                .minimumScaleFactor(1)
                .padding(4)
                .background(Color.gray)
                .foregroundColor(.white)
            Text(movie.numberOfSeasonsDisplay)
            if movie.isHD {
                Text("HD")
                    .bold()
                    .font(.system(size: 14))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
            }
        }
    }
}

struct MovieViewDescription: View {
    var movie: Movie

    var body: some View {
        Group {
            HStack {
                if let custom = movie.currentEpisodeInfo {
                    VStack(alignment: .leading) {
                        Text("S\(custom.season):E\(custom.episode) \(custom.episodeName)")
                            .bold()
                            .lineLimit(1)
                            .minimumScaleFactor(1)
                            .padding(.bottom, 4)
                        Text(custom.description)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                } else {
                    Text(movie.defaultEpisodeInfo.description)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

struct MovieViewCastInfo: View {
    var movie: Movie

    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text("Cast: \(movie.cast.joined(separator: ", "))")
                        .font(.system(size: 13))
                    Text("Creators: \(movie.creators.joined(separator: ", "))")
                        .font(.system(size: 13))
                }
                Spacer()
            }
            .padding(.bottom)
            .foregroundColor(.gray)
        }
    }
}
