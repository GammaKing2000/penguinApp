//
//  selectCalendarView.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 19/11/2024.
//

import SwiftUI

struct ChooseCalendarView: View {
    let calendars: [Calendar] = [
        Calendar(id: "google", image: Image(.calendarGoogle), name: "Google Calendar"),
        Calendar(id: "outlook", image: Image(.calendarOutlook), name: "Outlook Calendar"),
    ]
    var isFromSetting = true
    @State var selectedCalendarIndex = -1
    @State var isShowingConfirmation = false
    @Environment(\.presentationMode) var presentationMode
    
    init(isFromeSetting: Bool) {
        self.isFromSetting = isFromeSetting
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)], startPoint: .top, endPoint: .bottom)
                VStack {
                    VStack (alignment: .leading) {
                        Text("Choose your calendars")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Please choose your calendar so we can   help manage your schedule and  provide suggestions.")
                            .font(.body)
                    }
                    .frame(width: 340, height: 120)
                    HStack(spacing: 25) {
                        ForEach(0..<2) { index in
                            Button(action: {
                                selectedCalendarIndex = index
                            }) {
                                calendars[index].image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(14)
                                    .overlay(selectedCalendarIndex == index ? RoundedRectangle(cornerRadius: 14).stroke(Color(red: 109/256, green: 99/256, blue: 226/256), lineWidth: 3) : nil)
                            }
                        }
                    }.padding(50)
                    VStack (alignment: .center) {
                        if (isFromSetting) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Save")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 280, height: 23)
                                    .padding()
                                    .background(Color("AppPurple"))
                                    .cornerRadius(23)
                            }
                        } else {
                            NavigationLink(destination: SettingsPage().navigationBarBackButtonHidden(true)) {
                                Text("Later")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .frame(width: 280, height: 40)
                            }
                            NavigationLink(destination: ChooseActivityView().navigationBarBackButtonHidden(true)) {
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
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    ChooseCalendarView(isFromeSetting: false)
}
