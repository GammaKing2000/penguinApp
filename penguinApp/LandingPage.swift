//
//  Example.swift
//  Penguin
//
//  Created by Karman Fung on 17/11/2024.
//

import SwiftUI

struct Example: View {
    var body: some View {
        VStack {
            Text("Mr.Penguin")
                .font(.largeTitle.bold())
            Image("BigPenguin")
                .resizable()
                .scaledToFit()
                .frame(width:300 , height:300)
            Text("Chat with your life mate")
        }
    }
}
        //        TabView {
  //          Tab("Home", systemImage: "house.fill"){
                
                
//            Tab("Setting", systemImage: "gearshape.fill"){
//
//
//                Text("Hello, World 2")
//            }
//        }
//
//
//        NavigationStack
//                {
//                    NavigationLink {
//                        Text("Add Guest")
//                    } label: {
//                        Image(systemName: "person.badge.plus")
            

#Preview {
    Example()
}
