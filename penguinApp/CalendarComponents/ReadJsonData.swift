//
//  ReadJsonData.swift
//  penguinApp
//
//  Created by Nutnaree Duangdee on 24/11/2024.
//

import SwiftUI

// Define the model
struct Day: Codable, Identifiable {
    var id = UUID() // Automatically generates a unique identifier
    var date: Date
    var title: String
    var start: Date
    var end: Date
    var description: String
    
    // Custom DateFormatter for decoding
    enum CodingKeys: String, CodingKey {
        case date
        case title
        case start
        case end
        case description
    }
    
    // Custom date formatter for decoding the date fields
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy" // e.g., "Wednesday 27 November 2024"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    // Custom time formatter for decoding the time fields
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // e.g., "10:00 am" or "1:00 pm"
        return formatter
    }()
    
    // Custom decoding initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the date field with custom date formatter
        let dateString = try container.decode(String.self, forKey: .date)
        if let decodedDate = Day.dateFormatter.date(from: dateString) {
            self.date = decodedDate
        } else {
            self.date = Date() // Default to current date if decoding fails
        }
        
        // Decode the start and end fields with custom time formatter
        let startString = try container.decode(String.self, forKey: .start)
        if let decodedStart = Day.timeFormatter.date(from: startString) {
            self.start = decodedStart
        } else {
            self.start = Date() // Default to current date/time if decoding fails
        }
        
        let endString = try container.decode(String.self, forKey: .end)
        if let decodedEnd = Day.timeFormatter.date(from: endString) {
            self.end = decodedEnd
        } else {
            self.end = Date() // Default to current date/time if decoding fails
        }
        
        // Decode the other fields directly
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
    }
}

// Class to read JSON data
class ReadData: ObservableObject {
    @Published var days = [Day]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        // Locate the JSON file in the app bundle
        guard let url = Bundle.main.url(forResource: "DaySchedule", withExtension: "json") else {
            print("JSON file not found in the bundle.")
            return
        }
        do {
            // Load data from the file
            let data = try Data(contentsOf: url)
            
            // Decode the JSON data using a custom date formatter
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Day.dateFormatter)
            
            let decodedDays = try decoder.decode([Day].self, from: data)
            
            // Assign decoded data to the published property
            self.days = decodedDays
            
        } catch {
            // Handle errors
            print("Error loading or decoding JSON: \(error.localizedDescription)")
        }
    }
}
