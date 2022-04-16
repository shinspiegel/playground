//
//  SmallVerticalButton.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import SwiftUI

struct SmallVerticalButton: View {
    var text: String
    var onImage: String
    var offImage: String
    var isOn: Bool
    var action: () -> Void

    var image: String {
        if isOn {
            return onImage
        } else {
            return offImage
        }
    }

    var body: some View {
        Button(action: { action() }, label: {
            VStack {
                Image(systemName: self.image)
                Text(text)
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.white)
            }
        })
    }
}

struct SmallVerticalButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SmallVerticalButton(
                text: "My list",
                onImage: "checkmark",
                offImage: "plus",
                isOn: false
            ) {
                print("Tapped!")
            }.foregroundColor(.red)
        }
    }
}
