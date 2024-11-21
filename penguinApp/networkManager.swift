//
//  networkManager.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 21/11/2024.
//

import Foundation

struct ChatRequest: Codable {
    let prompt: String
    let hist_data: String
    let interests: [String]
}

struct ChatResponse: Codable {
    let response: String
    let history: String
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://192.168.210.60:8080/chat"
    
    private init() {}
    
    func sendChatRequest(prompt: String, history: String, interestList: [String], completion: @escaping (ChatResponse?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let chatRequest = ChatRequest(prompt: prompt, hist_data: history, interests: interestList)
        guard let body = try? JSONEncoder().encode(chatRequest) else { return }
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            if let chatResponse = try? decoder.decode(ChatResponse.self, from: data) {
                completion(chatResponse)
            } else {
                print("Failed to decode response")
                completion(nil)
            }
        }.resume()
    }
}

