//
//  SideBarView.swift
//  penguinApp
//
//  Created by Adit Vikram Mishra on 19/11/2024.
//

import SwiftUI

struct SideBarView: View {
    @Binding var isShowing: Bool
    @Binding var selectedActivities: [String]
    @State var selectedOption: SideBarOptionModel?
    @State var isNavigatingToMoodView: Bool = false
    @State var isProfileShowing: Bool = false
    @State var isSettingsShowing: Bool = false
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {isShowing.toggle()}
                
                HStack {
                    VStack(alignment: .leading, spacing: 32){
                        SideBarHeaderView()
                        
                        VStack{
                            ForEach(SideBarOptionModel.allCases) { option in
                                Button(action: {
                                    selectedOption = option
                                    if option == .newchat {
                                        isNavigatingToMoodView.toggle()
                                    }
                                    if option == .settings {
                                        isSettingsShowing.toggle()
                                    }
                                    if option == .profile {
                                        isProfileShowing.toggle()
                                    }
                                }, label: {
                                    SideBarRowView(option: option, selectedOption: $selectedOption)
                                })
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(Color.white)
                    
                    Spacer()
                }
                .sheet(isPresented: $isProfileShowing) {
                    profileView()
                }
            }
        }
        .transition(.move(edge: .leading))
        .animation(.smooth, value: isShowing)
        .background(
            NavigationLink(
                destination: MoodModelView(selectedActivities: $selectedActivities).navigationBarBackButtonHidden(true),
                isActive: $isNavigatingToMoodView,
                label: { EmptyView() }
            )
        ).sheet(isPresented: $isSettingsShowing){
            SettingsPage()
        }
    }
}

#Preview {
    SideBarView(isShowing: .constant(true), selectedActivities: .constant([]))
}
