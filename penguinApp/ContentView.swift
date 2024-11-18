//
//  ContentView.swift
//  Penguin1
//
//  Created by Nutnaree Duangdee on 18/11/2024.
//

import SwiftUI

struct MenuView: View {
    @State var showChooseActivity = false
    var body: some View {
        return Group {
            if showChooseActivity {
                ChooseActivityView()
            }
            else {
                ChooseCalendarView(showChooseActivity: $showChooseActivity)
            }
        }
    }
}

struct ChooseCalendarView: View {
    @Binding var showChooseActivity: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 500) {
            VStack (alignment: .leading) {
                Text("Choose your calendars")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Please choose your calendar so we can help manage your schedule and  provide suggestions.")
                    .font(.body)
            }
            .frame(width: 330)
            VStack (alignment: .center) {
                Button("Later") {
                    showChooseActivity.toggle()
                }
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                Button("Continue                                               ") {
                    showChooseActivity.toggle()
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215))
                    .controlSize(.extraLarge)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ChooseActivityView: View {
    @State var activity = ""
    var body: some View {
        VStack(alignment: .center, spacing: 533) {
            VStack (alignment: .leading) {
                Text("What activity do you like?")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Please select at least three items")
                    .font(.body)
            }
            .frame(width: 400)
            VStack (alignment: .center, spacing: 20) {
                TextField("Type more activities...", text:$activity)
                    .multilineTextAlignment(.center)
                Button("Continue                                               ") {
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215))
                    .controlSize(.extraLarge)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    MenuView()
}
