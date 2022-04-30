//
//  ContentView.swift
//  Study Reminder App
//
//  Created by Shin on 21/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct RoutesManager: View {
    @State var selected = 0
    
    var body: some View {
        NavigationView {
            Login()
                .navigationBarTitle("Login")

            TabView(selection: $selected) {
                Login()
                    .tag(0)
                    .navigationBarTitle("Login")
                    .tabItem { TabIcon(label: "Login", icon: "person.crop.circle") }
            }
            .accentColor(Constants.color.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesManager()
    }
}
