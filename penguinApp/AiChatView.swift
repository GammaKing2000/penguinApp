//
//  ChatView.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//

import SwiftUI

struct AiChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(isUser: false, text: "Hi, Jess! Are you ready to go out today?")
    ]
    @State private var userInput: String = ""
    @State private var showSideBar = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Chat Messages
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(messages) { message in
                                HStack {
                                    if message.isUser {
                                        Spacer()
                                        Text(message.text)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(Color.blue)
                                            .cornerRadius(15)
                                            .frame(maxWidth: 250, alignment: .trailing)
                                    } else {
                                        Text(message.text)
                                            .padding()
                                            .foregroundColor(.black)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(15)
                                            .frame(maxWidth: 250, alignment: .leading)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    // Input Field
                    HStack {
                        TextField("Type a message...", text: $userInput)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Button(action: {
                            sendMessage()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
                
//                SideBarView(isShowing: $showSideBar)
            }
            .toolbar(showSideBar ? .hidden : .visible,for: .navigationBar)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showSideBar.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                }
            }
        }
    }
    
    func sendMessage() {
        guard !userInput.isEmpty else { return }
        
        // Add user message
        messages.append(ChatMessage(isUser: true, text: userInput))
        
        // Clear input
        userInput = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = getAIResponse()
            messages.append(ChatMessage(isUser: false, text: aiResponse))
        }
    }
    
    func getAIResponse() -> String {
        // Simulate AI response logic
        return "That's interesting! Tell me more."
    }
}
#Preview {
    AiChatView()
}
