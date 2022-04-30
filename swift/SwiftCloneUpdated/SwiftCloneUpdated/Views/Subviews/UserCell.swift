//
//  UserCell.swift
//  SwiftCloneUpdated
//
//  Created by Shin Spiegel on 27/03/21.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image(systemName: "book")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Batman")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                
                Text("Bruce Wayne")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell().previewLayout(.sizeThatFits)
    }
}
