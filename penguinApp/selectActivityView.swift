//
//  selectActivityView.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 19/11/2024.
//

import SwiftUI
struct ChooseActivityView: View {
    func chooseActivity() {
        activitiesList.insert(activity, at:0)
        selectedActivities.append(activity)
        activity = ""
    }
    @State var selectedActivities: [String] = []
    @State var activity = ""
    @State var activitiesList = ["Football", "Basketball", "Bowling", "Kayaking", "Hiking", "Yoga", "Gaming", "Reading", "Cafe Hopping"]
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)], startPoint: .top, endPoint: .bottom)
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
                                .foregroundColor(selectedActivities.contains(activity) ? Color("AppPurple"): Color.black)
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
                        NavigationLink(destination: MoodModelView().navigationBarBackButtonHidden(true)) {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 280, height: 23)
                                .padding()
                                .background(Color("AppPurple"))
                                .cornerRadius(23)
                        }
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    ChooseActivityView()
}
