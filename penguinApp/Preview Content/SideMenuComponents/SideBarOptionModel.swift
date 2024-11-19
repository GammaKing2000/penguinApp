//
//  SideBarOptionModel.swift
//  penguinApp
//
//  Created by Adit Vikram Mishra on 19/11/2024.
//

import Foundation

enum SideBarOptionModel: Int, CaseIterable {
    case profile
    case history
    case calendar
    case settings
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .history: return "History"
        case .calendar: return "Calendar"
        case .settings: return "Settings"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .profile: return "person.crop.circle.fill"
        case .history: return "chart.bar.horizontal.page"
        case .calendar: return "calendar"
        case .settings: return "gearshape.fill"
        }
    }
}
    
    extension SideBarOptionModel: Identifiable {
        var id: Int { return self.rawValue}
    }
