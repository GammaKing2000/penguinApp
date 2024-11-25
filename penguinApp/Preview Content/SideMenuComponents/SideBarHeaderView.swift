//
//  SideBarHeaderView.swift
//  penguinApp
//
//  Created by Adit Vikram Mishra on 19/11/2024.
//

import SwiftUI

struct SideBarHeaderView: View {
    @AppStorage("name") private var name: String = "Name"
    @AppStorage("email") private var email: String = "Email"
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(Color("AppPurple"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            VStack(alignment: .leading, spacing: 6){
                Text(name)
                    .fontWeight(.semibold)
                Text(email)
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    SideBarHeaderView()
}
