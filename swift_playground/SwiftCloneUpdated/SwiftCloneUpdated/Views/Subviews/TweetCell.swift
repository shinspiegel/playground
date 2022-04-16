//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Shin on 24/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct TweetCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 56, height: 56)
                
                VStack(alignment: .leading){
                    HStack(spacing: 4) {
                        Text("Bruce")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text("@Batman")
                            .foregroundColor(.gray)
                        Text("•")
                            .foregroundColor(.gray)
                        Text("2w")
                            .foregroundColor(.gray)
                    }
                    
                    Text("something here")
                }
            }
            .padding(.horizontal)
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                })
            }
            .padding(.horizontal)
            .foregroundColor(.gray)
            
            Divider()
        }
        .padding(.vertical)
    }
}

struct TweetCell_Previews: PreviewProvider {
    static var previews: some View {
        TweetCell().previewLayout(.sizeThatFits)
    }
}
