//
//  settingactivitySelect.swift
//  penguinApp
//
//  Created by River on 25/11/2024.
//

import SwiftUI
import os

struct SettingActivitySelect: View {
    @Environment(\.presentationMode) var presentationMode
    
    func chooseActivity() {
       activitiesList.insert(activity, at:0)
       selectedActivities.append(activity)
        UserDefaults.standard.set(selectedActivities, forKey: "activities")
       activity = ""
   }
    func selectActivity(activity: String) {
        if (selectedActivities.contains(activity)) {
            selectedActivities.removeAll { $0 == activity }
        } else {
            selectedActivities.append(activity)
        }
        UserDefaults.standard.set(selectedActivities, forKey: "activities")
    }
    @State var selectedActivities: [String] = UserDefaults.standard.stringArray(forKey: "activities") ?? []
   @State var activity = ""
   @State var activitiesList = ["⚽️ Football", "🏀 Basketball", "🎳 Bowling", "🛶 Kayaking", "🥾 Hiking", "🧘‍♀️ Yoga", "🎮 Gaming", "📚 Reading", "☕️ Cafe Hopping"]
   @State private var keyboardHeight: CGFloat = 0
   
   private let keyboardWillShow = NotificationCenter.default
       .publisher(for: UIResponder.keyboardWillShowNotification)
       .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
       
   private let keyboardWillHide = NotificationCenter.default
       .publisher(for: UIResponder.keyboardWillHideNotification)
       .map { _ in CGFloat(0) }
   
   var body: some View {
       NavigationStack {
           ZStack {
               // Move the gradient to cover the entire screen including the padding
               LinearGradient(
                   colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)],
                   startPoint: .top,
                   endPoint: .bottom
               )
               .ignoresSafeArea()

               // Wrap the content VStack in another VStack to handle the keyboard padding
               VStack {
                   // Your existing content
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
                                       selectActivity(activity: activity)
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
                           /*
                           NavigationLink(destination: SettingsPage().navigationBarBackButtonHidden(true)) {
                               Text("Save")
                                   .fontWeight(.semibold)
                                   .foregroundColor(.white)
                                   .frame(width: 280, height: 23)
                                   .padding()
                                   .background(Color("AppPurple"))
                                   .cornerRadius(23)
                           }
                            */
                           Button(action: {
                               presentationMode.wrappedValue.dismiss();
                           }) {
                               Text("Save")
                                   .fontWeight(.semibold)
                                   .foregroundColor(.white)
                                   .frame(width: 280, height: 23)
                                   .padding()
                                   .background(Color("AppPurple"))
                                   .cornerRadius(23)
                           }
                       }
                   }
                   // Add the spacing at the bottom to account for keyboard
                   Spacer().frame(height: keyboardHeight - 180)
               }
           }
       }
       .onReceive(keyboardWillShow) { height in
           keyboardHeight = height
       }
       .onReceive(keyboardWillHide) { height in
           keyboardHeight = height
       }
   }
}

#Preview {
    SettingActivitySelect()
}
