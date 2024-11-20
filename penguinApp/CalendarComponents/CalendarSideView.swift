import SwiftUI
import Foundation

struct MonthlyCalendarView: View {
    @State private var currentDate = Date() // Current displayed date
    @State private var selectedDate: Date? = nil // Tracks the selected date
    @State private var isSheetShowing: Bool = false // Controls sheet visibility
    
    var body: some View {
        NavigationStack {
            VStack {
                // Month and Year Header
                HStack {
                    Button(action: {
                        currentDate = Foundation.Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding()
                    }

                    Spacer()

                    Text(monthYearFormatter.string(from: currentDate))
                        .font(.title)
                        .bold()

                    Spacer()

                    Button(action: {
                        currentDate = Foundation.Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .padding()
                    }
                }
                .padding(.horizontal)

                // Days of the Week Header
                HStack {
                    ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                        Text(day)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)

                // Calendar Grid
                let days = generateDays(for: currentDate)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 80) {
                    ForEach(days, id: \.self) { day in
                        if day != 0 {
                            Button(action: {
                                selectedDate = createDate(day: day, for: currentDate)
                                isSheetShowing = true // Show the sheet
                            }) {
                                Text("\(day)")
                                    .font(.body)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        selectedDate == createDate(day: day, for: currentDate)
                                            ? Color(red: 109/255, green: 99/255, blue: 226/255).opacity(0.2) // Purple for selected date
                                        : Color.clear // Default
                                    )
                                    .cornerRadius(8)
                                    .foregroundColor(
                                        selectedDate == createDate(day: day, for: currentDate)
                                            ? Color(red: 109/255, green: 99/255, blue: 226/255)
                                            : Color.black
                                    )
                            }
                        } else {
                            Text("") // Empty cells
                                .frame(maxWidth: .infinity, minHeight: 40)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer() // Ensures layout flexibility
            }
            .navigationTitle("Calendar")
            .navigationBarBackButtonHidden(false)
            .navigationBarItems(leading: NavigationLink(destination: AiChatView().navigationBarBackButtonHidden(true)) {
                Spacer()
                Image(.chatIcon)
            })
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isSheetShowing) { // Present the sheet
                if let selectedDate = selectedDate {
                    DayDetailView(date: selectedDate) // Pass the selected date to the detail view
                }
            }
        }
    }

    // Date Formatter for Header
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    // Generate Days for the Month
    private func generateDays(for date: Date) -> [Int] {
        let calendar = Foundation.Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        let firstWeekday = calendar.component(.weekday, from: startOfMonth) - 1 // Sunday = 1, adjust to 0-indexed

        // Empty slots for days before the first day of the month
        let leadingEmptyDays = Array(repeating: 0, count: firstWeekday)
        let days = Array(range)

        return leadingEmptyDays + days
    }

    // Create Date from Day and Month
    private func createDate(day: Int, for date: Date) -> Date {
        var components = Foundation.Calendar.current.dateComponents([.year, .month], from: date)
        components.day = day
        return Foundation.Calendar.current.date(from: components) ?? date
    }

    // Get Today's Day for the Current Month
    private func today(for date: Date) -> Int {
        let calendar = Foundation.Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        let todayMonth = calendar.component(.month, from: Date())

        if currentMonth == todayMonth {
            return calendar.component(.day, from: Date())
        }
        return -1 // No highlight
    }
}

struct DayDetailView: View {
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            Text("\(dateFormatter.string(from: date))")
                .font(.title)
                .bold()
                .padding()

            // Schedule List
            VStack(alignment: .leading, spacing: 15) {
                scheduleItem(time: "9:00 AM - 12:00 PM", title: "Morning Session", color: .blue)
                scheduleItem(time: "2:00 PM - 4:00 PM", title: "Afternoon Session", color: .green)
                scheduleItem(time: "5:00 PM - 6:00 PM", title: "Running", color: .appPurple)
            }
            .padding()

            Spacer()
        }
        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }

    // Schedule Item View
    private func scheduleItem(time: String, title: String, color: Color) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(time)
                    .font(.headline)
                    .foregroundColor(color)

                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

struct MonthlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendarView()
    }
}
