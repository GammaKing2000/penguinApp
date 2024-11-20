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

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.white, Color(red: 179 / 256, green: 193 / 256, blue: 221 / 256)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Spacer()
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
                                    .frame(width: 100, height: 100)
                                    .background(viewModel.selectedMood?.id == mood.id
                                                ? Color.blue.opacity(0.2)
                                                : Color.clear)
                                    .cornerRadius(10)

                                Text(mood.name)
                                    .font(.system(size: 14))
                            }
                            .onTapGesture {
                                viewModel.selectMood(mood)
                                navigateToChat = true // Trigger navigation programmatically
                            }
                        }
                    }
                    .frame(maxWidth: 340)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 200, trailing: 0))

                    // Chat input box with paper plane icon
                    HStack {
                        TextField("Tell me how you're feeling...", text: $chatInput)
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                        Button(action: {
                            if !chatInput.isEmpty {
                                navigateToChat = true
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                    .frame(maxWidth: 340)
                }
                .frame(width: 340, height: 700)
            }
            .ignoresSafeArea()
            .navigationBarItems(
                leading: Button(action: {}) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                },
                trailing: Button(action: {}) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .navigationDestination(isPresented: $navigateToChat) {
                ChatView(userInput: viewModel.selectedMood?.name ?? chatInput)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ChatView: View {
    let userInput: String

    var body: some View {
        VStack {
            Text("Chat with AI")
                .font(.largeTitle)
                .padding()

            ScrollView {
                Text("You feel: \(userInput)")
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("AI Chat")
    }
}

struct MoodViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MoodModelView()
    }
}

//import SwiftUI
//
//class MoodViewModel: ObservableObject {
//    @Published var moods: [Mood] = [
//        Mood(name: "Frustrated", imageName: "frustrated_penguin"),
//        Mood(name: "Thirsty", imageName: "thirsty_penguin"),
//        Mood(name: "Tired", imageName: "tired_penguin"),
//        Mood(name: "Sporty", imageName: "sporty_penguin"),
//        Mood(name: "Happy", imageName: "happy_penguin"),
//        Mood(name: "Weekend", imageName: "weekend_penguin")
//    ]
//    
//    @Published var selectedMood: Mood?
//    
//    func selectMood(_ mood: Mood) {
//        selectedMood = mood
//    }
//}
//
//struct MoodModelView: View {
//    @StateObject private var viewModel = MoodViewModel()
//    @State private var chatInput: String = ""
//    @State private var isChatActive: Bool = false
//
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Hi, Jess!")
//                    .font(.system(size: 32, weight: .bold))
//                
//                Text("How are you feeling today?")
//                    .font(.system(size: 24, weight: .bold))
//                
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(viewModel.moods) { mood in
//                        VStack {
//                            Image(mood.imageName)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 80, height: 80)
//                                .padding(8)
//                                .background(viewModel.selectedMood?.id == mood.id ?
//                                          Color.blue.opacity(0.2) : Color.clear)
//                                .cornerRadius(10)
//                            
//                            Text(mood.name)
//                                .font(.system(size: 14))
//                        }
//                        .onTapGesture {
//                            viewModel.selectMood(mood)
//                            isChatActive = true // Navigate directly to the chat
//                        }
//                    }
//                }
//                .padding()
//                
//                Spacer()
//
//                // Chat input box with paper plane icon
//                HStack {
//                    TextField("Tell me how you're feeling...", text: $chatInput)
//                        .padding(10)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(20)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                    
//                    Button(action: {
//                        if !chatInput.isEmpty {
//                            isChatActive = true
//                        }
//                    }) {
//                        Image(systemName: "paperplane.fill")
//                            .foregroundColor(.white)
//                            .padding(10)
//                            .background(Color.black)
//                            .clipShape(Circle())
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 20)
//            }
//            .padding(.top, 40)
//            .background(
//                NavigationLink(destination: ChatView(userInput: viewModel.selectedMood?.name ?? chatInput).navigationBarBackButtonHidden(true),
//                               isActive: $isChatActive) {
//                    EmptyView()
//                }
//                .hidden()
//            )
//            .navigationBarItems(
//                leading: Button(action: {}) {
//                    Image(systemName: "line.horizontal.3")
//                        .imageScale(.large)
//                },
//                trailing: Button(action: {}) {
//                    Image(systemName: "plus")
//                        .imageScale(.large)
//                }
//            )
//        }
//    }
//}
//
//struct ChatView: View {
//    let userInput: String
//
//    var body: some View {
//        VStack {
//            Text("Chat with AI")
//                .font(.largeTitle)
//                .padding()
//
//            ScrollView {
//                Text("You feel: \(userInput)")
//                    .padding()
//            }
//
//            Spacer()
//        }
//        .navigationTitle("AI Chat")
//    }
//}
//
//struct MoodViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodModelView()
//    }
//}
