//
//  ContentView.swift
//  Penguin1
//
//  Created by Nutnaree Duangdee on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Choose your calendars")
                .font(.title)
                .fontWeight(.bold)
            Text("Please choose your calendar so we can help manage your schedule and  provide suggestions.")
                .font(.body)
            
        }
        .frame(width: 330)
//        .padding(EdgeInsets(top: -300, leading: -20, bottom: 0, trailing: 0))
    }
}

#Preview {
    ContentView()
}
