//
//  Feed.swift
//  Twitter Clone
//
//  Created by Shin on 23/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct FeedScreen: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        TweetCell()
                    }
                }
            }
            
            Button(action: {}, label: {
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            })
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
    }
}
