//
//  SideBarRowView.swift
//  penguinApp
//
//  Created by Adit Vikram Mishra on 19/11/2024.
//

import SwiftUI

struct SideBarRowView: View {
    let option: SideBarOptionModel
    @Binding var selectedOption: SideBarOptionModel?
    
    private var isSelected: Bool {
        return selectedOption == option
    }
    var body: some View {
        HStack{
            Image(systemName: option.systemImageName)
                .imageScale(.small)
            Text(option.title)
                .font(.subheadline)
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .purple : .primary)
        .frame( width: 216, height: 44)
        .background(isSelected ? .purple.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SideBarRowView(option: .calendar, selectedOption: .constant(.calendar))
}
