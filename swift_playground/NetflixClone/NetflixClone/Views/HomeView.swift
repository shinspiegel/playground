//
//  HomeView.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import SwiftUI

struct HomeView: View {
    var screen = PhoneDetails.screen
    var modelView = HomeScreenVM()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVStack {
                    TopRowButtons()
                    
                    TopPreviewMovie(movie: modelView.topVideo)
                        .frame(width: PhoneDetails.screen.width, height: PhoneDetails.screen.height * 0.7, alignment: .bottom)
                        .clipped()
                        .padding(.top, -110)
                        .zIndex(-1)
                    
                    ForEach(modelView.allCategories, id: \.self) { category in
                        VStack {
                            HStack {
                                Text(category)
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(modelView.getMovies(category)) { movie in
                                        StandardMovie(movie: movie)
                                            .frame(width: 100, height: 200)
                                            .padding(.horizontal, 18)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TopRowButtons: View {
    var body: some View {
        HStack {
            NetflixButton {}.frame(width: 50).buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {}) { Text("TV Show") }.buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {}) { Text("Movies") }.buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {}) { Text("My List") }.buttonStyle(PlainButtonStyle())
        }
        .padding(.leading, 10)
        .padding(.trailing, 30)
    }
}
