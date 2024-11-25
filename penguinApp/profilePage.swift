//
//  profilePage.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 25/11/2024.
//

import SwiftUI

struct profileView: View {
    @AppStorage("name") private var name: String = "Name"
    @AppStorage("email") private var email: String = "Email"
    var body: some View {
        VStack (alignment: .center) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            TextField("Name", text: $name )
                .font(.title)
                .fontWeight(.bold)
                .frame(width: .infinity)
                .multilineTextAlignment(.center)
            TextField("Email", text: $email )
                .font(.headline)
                .frame(width: .infinity)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    profileView()
}
