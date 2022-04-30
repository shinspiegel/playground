//
//  NetflixButton.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 28/03/21.
//

import SwiftUI

struct NetflixButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: { action() }) {
            Image("netflix_logo")
                .resizable()
                .scaledToFit()
        }
    }
}

struct NetflixButton_Previews: PreviewProvider {
    static var previews: some View {
        NetflixButton(action: {}).frame(width: 40)
    }
}
