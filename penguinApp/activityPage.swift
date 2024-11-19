//
//  ContentView.swift
//  Mr. Penguin
//
//  Created by River on 18/11/2024.
//

import SwiftUI

struct ActivityPageView: View {
    @State var backgroundGradient = LinearGradient(
        // colors: [Color.white, Color(red: 179, green: 193, blue: 221)],
        colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)],
        startPoint: .top, endPoint: .bottom)
    @State var showChooseActivity = false
    var body: some View {
        return Group {
            if showChooseActivity {
                ChooseActivityView(backgroundGradient: $backgroundGradient)
            }
            else {
                ChooseCalendarView(showChooseActivity: $showChooseActivity, backgroundGradient: $backgroundGradient)
            }
        }
    }
}


struct ChooseCalendarView: View {
    @Binding var showChooseActivity: Bool
    @Binding var backgroundGradient: LinearGradient
    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
                VStack (alignment: .leading) {
                    Text("Choose your calendars")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Please choose your calendar so we can   help manage your schedule and  provide suggestions.")
                        .font(.body)
                }
                .frame(width: 340, height: 120)
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
                .frame(width: 340, height: 100)
            }
        }.ignoresSafeArea()
    }
}

struct ChooseActivityView: View {
    let images = [
        Image(.activity1Football), Image(.activity2Basketball),
        Image(.activity3Bowling), Image(.activity4Kaya),
        Image(.activity5Hiking), Image(.activity6Yoga),
        Image(.activity7Game), Image(.activity8Coffee),
        Image(.activity9Book)
    ]
    @State var activity = ""
    @Binding var backgroundGradient: LinearGradient
    var body: some View {
        ZStack {
            backgroundGradient
            VStack(alignment: .center) {
                VStack (alignment: .leading) {
                    Text("What activity do you like?")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Please select at least three items")
                        .font(.body)
                }
                    .frame(width: 340, height: 120)
                
                Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                           ForEach(0..<3) { row in
                               GridRow {
                                   ForEach(0..<3) { column in
                                       let index = row * 3 + column
                                       if index < images.count {
                                           images[index]
                                               .resizable()
                                               .aspectRatio(contentMode: .fill)
                                               .frame(width: 100, height: 100)
                                               .background(Color.gray.opacity(0.2))
                                               .cornerRadius(14)
                                       }
                                   }
                               }
                           }
                       }
                       .padding()
                VStack (alignment: .center, spacing: 40) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 300, height: 50)
                        TextField("Type more activities...", text:$activity)
                            .multilineTextAlignment(.center)
                    }
                    Button("Continue                                               ") {
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215))
                    .controlSize(.extraLarge)
                    .fontWeight(.semibold)
                }
                //            .frame(width: 340, height: 100)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ActivityPageView()
}
