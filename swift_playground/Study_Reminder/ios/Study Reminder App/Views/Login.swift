//
//  Login.swift
//  Study Reminder App
//
//  Created by Shin on 21/03/21.
//  Copyright © 2021 Shin Spiegel. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var pass = ""
    
    var body: some View {
        ZStack {
            Constants.color.primary.edgesIgnoringSafeArea(.all)
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $pass)
                HStack {
                    Button(action: {}) { Text("Login") }
                    Spacer()
                    Button(action: {}) { Text("Login") }
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
