//
//  SearchScreen.swift
//  Twitter Clone
//
//  Created by Shin on 24/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct SearchScreen: View {
    @State var searchText = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding(.horizontal, 8)
                .padding(.top, 8)
            
            VStack{
                ForEach(0..<10) { _ in
                    UserCell()
                }
            }
            
        }
        .navigationBarTitle("Search")
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
