//
//  CustomTabSwitcher.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 01/04/21.
//

import SwiftUI

struct CustomTabSwitcher: View {
    @State private var currentTab: CustomTab = .episodes

    var tabs: [CustomTab]
    var movie: Movie

    func widthForTab(_ tab: CustomTab) -> CGFloat {
        let string = tab.rawValue
        return string.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
    }

    func tabSize(_ tab: CustomTab) -> CGFloat {
        if currentTab == tab {
            return widthForTab(tab)
        }

        return 0
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: tabSize(tab), height: 6)
                                .foregroundColor(tab == currentTab ? Color.red : Color.clear)
                                .animation(.easeOut(duration: 0.2))

                            Button(action: {
                                currentTab = tab
                            }, label: {
                                Text(tab.rawValue)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(tab == currentTab ? Color.white : Color.gray)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(width: widthForTab(tab))
                            })
                        }
                    }
                }
            }

            switch currentTab {
            case .episodes:
                Text("Episode")
            case .trailer:
                TrailerList(trailers: movie.trailers)
            case .more:
                MoreLikeThis(movies: movie.moveLikeThis)
            }
        }
        .foregroundColor(.white)
    }
}

enum CustomTab: String {
    case episodes = "EPISODES"
    case trailer = "TRAILER & MORE"
    case more = "MORE LIKE THIS"
}

struct CustomTabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            CustomTabSwitcher(
                tabs: [.episodes, .trailer, .more],
                movie: ExempleMovie
            )
        }
    }
}
