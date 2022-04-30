//
//  TopPreviewMovie.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import KingfisherSwiftUI
import SwiftUI

struct TopPreviewMovie: View {
    var movie: Movie
    
    func isLast(_ item: String) -> Bool {
        let count = movie.categories.count
        
        if let index = movie.categories.firstIndex(of: item) {
            if index + 1 == count {
                return true
            }
        }
        
        return false
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(movie.thumbnail)
                .resizable()
                .scaledToFill()
            
            VStack {
                HStack {
                    ForEach(movie.categories, id: \.self) { category in
                        HStack {
                            Text(category)
                                .font(.footnote)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            
                            if !isLast(category) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 4))
                            }
                        }
                    }
                }
                .padding(.bottom, 4)
                
                HStack {
                    Spacer()
                    
                    SmallVerticalButton(
                        text: "My List",
                        onImage: "checkmark",
                        offImage: "plus",
                        isOn: false) {
                            // TODO:
                    }
                    
                    Spacer()
                    
                    BaseButton(text: "Play", icon: "play.fill") {
                        // TODO:
                    }
                    .frame(width: 120)
                    
                    Spacer()
                    
                    SmallVerticalButton(
                        text: "Info",
                        onImage: "info.circle",
                        offImage: "info.circle",
                        isOn: false) {
                            // TODO:
                    }
                    
                    Spacer()
                }
                .padding(.bottom)
            }
            .background(LinearGradient.fadeToBlackGradiente)
        }
        .foregroundColor(.white)
    }
}

struct TopPreviewMovie_Previews: PreviewProvider {
    static var previews: some View {
        TopPreviewMovie(movie: ExempleMovie)
            .frame(width: PhoneDetails.screen.width, height: PhoneDetails.screen.height * 0.7, alignment: .bottom)
            .clipped()
    }
}
