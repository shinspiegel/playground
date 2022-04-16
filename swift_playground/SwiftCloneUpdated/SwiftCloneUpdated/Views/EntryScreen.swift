//
//  ContentView.swift
//  Twitter Clone
//
//  Created by Shin on 23/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct EntryScreen: View {
    var body: some View {
        NavigationView {
            
            TabView {
                FeedScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                }
                
                SearchScreen()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                        
                }
                
                Text("Message")
                    .tabItem {
                        Image(systemName: "envelope")
                        Text("Messages")
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct EntryScreen_Previews: PreviewProvider {
    static var previews: some View {
        EntryScreen()
    }
}
