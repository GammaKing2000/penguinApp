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
    @State var activitiesList = ["Football", "Basketball", "Bowling", "Kayaking", "Hiking", "Yoga", "Gaming", "Reading", "Cafe Hopping"]
    @State var selectedActivities: [String] = []
    var body: some View {
        return Group {
            if showChooseActivity {
                ChooseActivityView(selectedActivities: $selectedActivities, backgroundGradient: $backgroundGradient, activitiesList: $activitiesList)
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
    func chooseActivity() {
        activitiesList.insert(activity, at:0)
        selectedActivities.append(activity)
        activity = ""
    }
    @Binding var selectedActivities: [String]
    @State var activity = ""
    @Binding var backgroundGradient: LinearGradient
    @Binding var activitiesList: [String]
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
                List {
                    ForEach(activitiesList, id: \.self){ activity in
                        Text(activity)
                            .fontWeight(selectedActivities.contains(activity) ? .bold : .light)
                            .foregroundColor(selectedActivities.contains(activity) ? Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215): Color.black)
                            .onTapGesture {
                                selectedActivities.contains(activity) ? selectedActivities.removeAll { $0 == activity } : selectedActivities.append(activity)
                            }
                    }
                }
                .frame(width: 340, height: 460)
                .scrollContentBackground(.hidden)
                VStack (alignment: .center, spacing: 40) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 300, height: 50)
                        TextField("Type more activities...", text:$activity)
                            .onSubmit {
                                chooseActivity()
                            }
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
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ActivityPageView()
}
