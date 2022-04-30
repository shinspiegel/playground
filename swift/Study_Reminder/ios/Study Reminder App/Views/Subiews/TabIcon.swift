//
//  TabIcon.swift
//  Study Reminder App
//
//  Created by Shin on 21/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct TabIcon: View {
    let label: String
    let icon: String
    
    var body: some View {
        VStack{
            Image(systemName: icon)
                .resizable()
                .foregroundColor(Constants.color.primary)
                .frame(width: 30, height: 30, alignment: .center)
            Text(label)
                .foregroundColor(Constants.color.primary)
                .fontWeight(.bold)
        }
    }
}

struct TabIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabIcon(label: "Name", icon: "person.crop.circle").previewLayout(.sizeThatFits)
    }
}
