//
//  WelcomeView.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//
//
import SwiftUI

struct WelcomeView: View {
    @State private var showChooseCalendar = false
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(red: 186/256, green: 183/256, blue: 216/256), Color(red: 177/256, green: 194/256, blue: 221/256)], startPoint: .top, endPoint: .bottom)
                VStack {
                    Image("BigPenguin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                    Text("Mr. Penguin")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 350, height: 20)
                    Text("Chat with your life mate")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 10)
                        .padding(.top, 40)
                    NavigationLink (destination: ChooseCalendarView().navigationBarBackButtonHidden(true)) {
                        Text("Let's start!")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 280, height: 23)
                            .padding()
                            .background(Color("AppPurple"))
                            .cornerRadius(23)
                    }
                    .padding(.top, 5)
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}


