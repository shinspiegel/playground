//
//  WhiteButton.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import SwiftUI

struct BaseButton: View {
    var text: String
    var icon: String
    var foregroundColor = Color.black
    var backgroundColor = Color.white
    var action: () -> Void

    var body: some View {
        Button(action: { action() }, label: {
            HStack {
                Spacer()
                Image(systemName: icon)
                Text(text)
                Spacer()
            }
            .padding(.vertical, 6)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(4)
        })
    }
}

struct BaseButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            BaseButton(text: "Play", icon: "play.fill") {
                print("Pressed!")
            }
        }
    }
}
