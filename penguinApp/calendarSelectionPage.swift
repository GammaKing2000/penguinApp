//
//  calendarSelectionPage.swift
//  penguinApp
//
//  Created by River on 19/11/2024.
//
import SwiftUI

struct Calender {
    var id: String
    var image: Image
    var name: String
}

struct ChooseCalendarView: View {
    @State var backgroundGradient = LinearGradient(
        // colors: [Color.white, Color(red: 179, green: 193, blue: 221)],
        colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)],
        startPoint: .top, endPoint: .bottom)
    
    let clanders: [Calender] = [
        Calender(id: "google", image: Image(.calenderGoogle), name: "Google Calendar"),
        Calender(id: "outlook", image: Image(.calenderOutlook), name: "Outlook Calendar"),
        Calender(id: "ms", image: Image(.calenderMircrosoft), name: "Microsoft Calendar"),
    ]

    @State var selectedCalendarIndex = -1
    @State var isShowingConfirmation = false
    
    @Binding var showChooseActivity: Bool
    var body: some View {
        ZStack {
            backgroundGradient
            VStack(spacing: 20) {
                VStack (alignment: .leading) {
                    Text("Choose your calendars")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Please choose your calendar so we can   help manage your schedule and  provide suggestions.")
                        .font(.body)
                }
                .frame(width: 340, height: 120)
                
                HStack(spacing: 25) {
                    ForEach(0..<3) { index in
                        Button(action: {
                            selectedCalendarIndex = index
                        }) {
                            clanders[index].image
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
                    Button("Later") {
                        showChooseActivity.toggle()
                    }
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                    Button("Continue                                               ") {
                        isShowingConfirmation.toggle()
                    }
                        
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215))
                        .controlSize(.extraLarge)
                        .fontWeight(.semibold)
                        .disabled(selectedCalendarIndex < 0)
                        .confirmationDialog(
                            "Mr.Penguin would like to access your calendar",
                            isPresented: $isShowingConfirmation,
                            titleVisibility: .visible) {
                            Button("Cancel", role: .cancel) {}
                            Button("Continue") {
                                showChooseActivity.toggle()
                            }
                            } message: {
                                Text("You will be navigated to the calendar app to approve the connection.")
                            }
                }
                .frame(width: 340, height: 100)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ChooseCalendarView(showChooseActivity: .constant(false))
}
