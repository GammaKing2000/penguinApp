//
//  WelcomeView.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//

import SwiftUI

struct WelcomeView: View {
    let onContinue: () -> Void
    
    @State var backgroundGradient = LinearGradient(colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)], startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack {
            backgroundGradient
            VStack(spacing: 20) {
                Image("BigPenguin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Mr. Penguin")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Chat with your life mate")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Button(action: onContinue) {
                    Text("Get Started")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.vertical, 10)
                        .background(Color(red: 0.42745098039215684, green: 0.38823529411764707, blue: 0.8862745098039215))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
            }
            .padding()
        }.ignoresSafeArea()
    }
}

#Preview {
    WelcomeView(onContinue: {
        // Empty closure for preview
    })
}
