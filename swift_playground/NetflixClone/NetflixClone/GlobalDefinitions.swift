//
//  GlobalDefinitions.swift
//  NetflixClone
//
//  Created by Shin Spiegel on 27/03/21.
//

import Foundation
import SwiftUI

struct PhoneDetails {
    static var screen = UIScreen.main.bounds
}

extension LinearGradient {
    static let fadeToBlackGradiente = LinearGradient(
        gradient:
            Gradient(colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(1)
            ]),
        startPoint: .top,
        endPoint: .bottom
    )
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
