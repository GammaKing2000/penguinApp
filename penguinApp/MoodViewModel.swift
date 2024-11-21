//
//  MoodViewModel.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//

import SwiftUI

class MoodViewModel: ObservableObject {
    @Published var moods: [Mood] = [
        Mood(name: "Frustrated", imageName: "frustrated_penguin"),
        Mood(name: "Thirsty", imageName: "thirsty_penguin"),
        Mood(name: "Tired", imageName: "tired_penguin"),
        Mood(name: "Sporty", imageName: "sporty_penguin"),
        Mood(name: "Happy", imageName: "happy_penguin"),
        Mood(name: "Weekend", imageName: "weekend_penguin")
    ]
    
    @Published var selectedMood: Mood?
    
    func selectMood(_ mood: Mood) {
        selectedMood = mood
    }
}

struct MoodModelView: View {
    @StateObject private var viewModel = MoodViewModel()
    @State private var chatInput: String = ""
    @State private var navigateToChat: Bool = false
    @State private var showSideBar = false
    @State private var messages: [ChatMessage] = []
    @State private var userInput: String = ""
    @State private var history: String = ""
    @FocusState private var isInputFocused: Bool // New focus state

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func sendMessageToLLM() {
        let prompt = chatInput
        let hist = history
        NetworkManager.shared.sendChatRequest(prompt: prompt, history: hist) { response in
            guard let response = response else { return }
            DispatchQueue.main.async {
//                messages.append(ChatMessage(isUser: true, text: prompt))
                messages.append(ChatMessage(isUser: false, text: response.response))
                history = response.history
                chatInput = ""
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                VStack {
                    if !navigateToChat {
                        VStack {
                            Text("Hi, Jess! How are you feeling today?")
                                .font(.system(size: 32, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .frame(width: 340)
                            LazyVGrid(columns: columns, spacing: 30) {
                                ForEach(viewModel.moods) { mood in
                                    VStack {
                                        Image(mood.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100)
                                            .background(viewModel.selectedMood?.id == mood.id
                                                        ? Color.blue.opacity(0.2)
                                                        : Color.clear)
                                            .cornerRadius(10)
                                        
                                        Text(mood.name)
                                            .font(.system(size: 14))
                                    }
                                    .onTapGesture {
                                        viewModel.selectMood(mood)
                                        messages.append(ChatMessage(isUser: false, text: "Hi, Jess! Are you feeling " + mood.name.lowercased() + " today?"))
                                        navigateToChat = true
                                    }
                                }
                            }
                            .frame(maxWidth: 340, maxHeight: 500)
                        }
                        .frame(width: 340)
                    }
                    else {
                        VStack {
                            // Chat Messages with ScrollView and ScrollViewReader
                            ScrollViewReader { proxy in
                                ScrollView {
                                    VStack(alignment: .leading, spacing: 10) {
                                        ForEach(messages) { message in
                                            HStack {
                                                if message.isUser {
                                                    Spacer()
                                                    Text(message.text)
                                                        .padding()
                                                        .foregroundColor(.white)
                                                        .background(Color("AppPurple"))
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
                                            .id(message.id) // Add unique id for scrolling
                                        }
                                    }
                                    .padding()
                                }
                                .onChange(of: messages.count) { _ in
                                    // Scroll to the last message when new message is added
                                    withAnimation {
                                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                                    }
                                }
                                // Add gesture to dismiss or show keyboard
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if value.translation.height > 0 {
                                                // Dismiss keyboard when dragging down
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            } else {
                                                // Show keyboard when dragging up
                                                isInputFocused = true
                                            }
                                        }
                                )
                            }
                        }
                    }
                    HStack {
                        TextField("Tell me how you're feeling...", text: $chatInput, axis: .vertical) // Add vertical axis
                            .lineLimit(4) // Limit to 4 lines
                            .focused($isInputFocused) // Connect focus state
                            .textFieldStyle(PlainTextFieldStyle()) // Remove default styling
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onSubmit {
                                sendMessageToChat()
                                sendMessageToLLM()
                            }
                        
                        Button(action: {
                            if !chatInput.isEmpty {
                                sendMessageToChat()
                                sendMessageToLLM()
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("AppPurple"))
                                .clipShape(Circle())
                        }
                    }
                    .frame(maxWidth: 340)
                }
                SideBarView(isShowing: $showSideBar)
            }
            .navigationBarItems(
                leading: Button(action: {showSideBar.toggle()}) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                },
                trailing: Button(action: {}) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
        }
    }
    
    // Separate method to send message
    private func sendMessageToChat() {
        messages.append(ChatMessage(isUser: true, text: chatInput))
        navigateToChat = true
        chatInput = "" // Clear input
        // isInputFocused = false // Optionally dismiss keyboard after sending
    }
}

struct MoodViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MoodModelView()
    }
}
