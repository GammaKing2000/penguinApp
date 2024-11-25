import SwiftUI

struct SettingsPage: View {
    @State private var showCalendarPicker = false
    @State private var additionalActivities = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    NavigationLink(destination: ChooseCalendarView(isFromeSetting: true)) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "calendar.badge.plus")
                                Text("Add Calendar").foregroundColor(.black)
                            }
                        }
                    }
                    
                    NavigationLink(destination: SettingActivitySelect()) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add More Activities").foregroundColor(.black)
                            }
                        }
                    }

                }
                
//                Section(header: Text("Appearance")) {
//                    Toggle(isOn: $isDarkMode) {
//                        HStack {
//                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
//                            Text(isDarkMode ? "Dark Mode" : "Light Mode")
//                        }
//                    }
//                }
//                
                Section {
                    Button(action: {
                        // Log out action
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward.circle")
                            Text("Log Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
