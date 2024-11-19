//
//  selectCalendarView.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 19/11/2024.
//

import SwiftUI

struct ChooseCalendarView: View {
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
                    VStack (alignment: .center) {
                        NavigationLink(destination: ChooseCalendarView().navigationBarBackButtonHidden(true)) {
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
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    ChooseCalendarView()
}
