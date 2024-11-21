//
//  SideBarView.swift
//  penguinApp
//
//  Created by Adit Vikram Mishra on 19/11/2024.
//

import SwiftUI

struct SideBarView: View {
    @Binding var isShowing: Bool
    @State var selectedOption: SideBarOptionModel?
    @State var isNavigatingToMoodView: Bool = false
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
                                        isNavigatingToMoodView = true
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
            }
        }
        .transition(.move(edge: .leading))
        .animation(.smooth, value: isShowing)
        .background(
            NavigationLink(
                destination: MoodModelView().navigationBarBackButtonHidden(true),
                isActive: $isNavigatingToMoodView,
                label: { EmptyView() }
            )
        )
    }
}

#Preview {
    SideBarView(isShowing: .constant(true))
}
