//
//  ContentView.swift
//  amigo
//
//  Created by Amogh on 06/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            TabView{
                    HomeView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Discover")
                    }
//                BookingView()
//                    .tabItem {
//                        Image(systemName: "bookmark.circle")
//                        Text("My Booking")
//                    }
//                OrderDetailView()
//                    .tabItem {
//                        Image(systemName: "deskclock.fill")
//                        Text("My Booking")
//                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }

            }
        }
    }
}

//#Preview {
//    ContentView()
//}
