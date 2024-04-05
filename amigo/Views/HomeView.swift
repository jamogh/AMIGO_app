//
//  HomeView.swift
//  amigo
//
//  Created by Amogh on 06/03/24.
//


import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isProfileActive: Bool = false
    @State var searchText = ""
    @State var isPresentingTour: Bool = false
    @State var isPresentingSeeMoreEvent: Bool = false
    @State private var selectedTourID: String = ""
    @StateObject var homeViewModel = HomeViewModel()
    @State private var isTourDetailPresented = false
    
    var body: some View {
        NavigationView{
        ZStack{
            if(colorScheme == .dark){
                Color.black
                    .ignoresSafeArea()
            }
            else{
                Color(red: 242/255, green: 241/255, blue: 246/255)
                    .ignoresSafeArea()
            }
            ScrollView(){
                
                VStack(spacing:16){
                    VStack {
                        HStack {
                            Text("Top Visited")
                                .font(Font.custom("SF Pro Display Semibold",size: 24,relativeTo: .title))
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding([.leading,.trailing],16)
                            Spacer()
//                            Button {
//                                isPresentingSeeMoreEvent.toggle()
//                            } label: {
//                                Text("See More")
//                                    .padding(.trailing)
//                            }
                            .sheet(isPresented: $isPresentingSeeMoreEvent) {
                                //CreateEventView()
                            }
                        }
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
//                                ForEach(0..<2, id: \.self){i in
//                                    Button {
//                                        isPresentingTour.toggle()
//                                      
//                                    } label: {
//                                        VStack(alignment:.leading){
//                                            Image("thailand")
//                                                .resizable()
////                                                .frame(width: 200,height: 150)
//                                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                                            .scaledToFill()
//                                           Text("Thailand")
//                                                .padding(.leading,5)
//                                                .foregroundColor(.black)
//                                        }
//                                        //.padding(.bottom)
//                                    }
//                                    .padding([.leading])
//                                }
                                let n = 3
                                let startIndex = max(0, homeViewModel.cities.count - n)
                                let endIndex = homeViewModel.cities.count
                                ForEach(startIndex..<endIndex, id: \.self){i in
                                    Button{
                                        isTourDetailPresented.toggle()
                                        selectedTourID = homeViewModel.cities[i].name
                                        
                                    }
                                label:{
                                    VStack(alignment:.leading){
                                        if(homeViewModel.cities[i].imageReferenceID == ""){
                                            Image("thailand")
                                                .resizable()
                                                .scaledToFill()
//                                                .frame(width: UIScreen.main.bounds.width - 32,height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                        else{
                                            let imageURL=URL(string: homeViewModel.cities[i].imageReferenceID)
                                            WebImage(url: imageURL!)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: (UIScreen.main.bounds.width - 32)/1.5,height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                        
                                        //.scaledToFill()
                                        HStack{
                                            VStack(alignment:.leading){
                                                Text(homeViewModel.cities[i].name)
                                                    .foregroundColor(.black)
                                              //  Text(homeViewModel.cities[i].features)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(.leading,5)
                                            Spacer()
//                                            Text("$\(homeViewModel.cities[i].price)")
//                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                    //.padding(.bottom)
                                .padding([.leading])
                                    
                                    
                                    
                                }
                            }
                        }
                        
                    }
               //     .searchable(text: $searchText)
                    
                    VStack {
                        HStack {
                            Text("Recommended")
                                .font(Font.custom("SF Pro Display Semibold",size: 24,relativeTo: .title))
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding([.leading,.trailing],16)
                            
                        }
                        if homeViewModel.cities.count > 0{
                            VStack{
                            ForEach(0..<homeViewModel.cities.count, id: \.self){i in
                                Button{
                                    isTourDetailPresented.toggle()
                                    selectedTourID = homeViewModel.cities[i].name
                                    
                                }
                            label:{
                                VStack(alignment:.leading){
                                    if(homeViewModel.cities[i].imageReferenceID == ""){
                                        Image("thailand")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width - 32,height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    else{
                                        let imageURL=URL(string: homeViewModel.cities[i].imageReferenceID)
                                        WebImage(url: imageURL!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width - 32,height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    
                                    //.scaledToFill()
                                    HStack{
                                        VStack(alignment:.leading){
                                            Text(homeViewModel.cities[i].name)
                                                .foregroundColor(.black)
//                                            Text(homeViewModel.cities[i].features)
//                                                .foregroundColor(.secondary)
                                            ForEach(homeViewModel.cities[i].features, id: \.self) { feature in
                                                
                                                    
                                                     // Add spacer to push Text(language) to the trailing edge
                                                    Text(feature)
                                                        .font(Font.custom("SF Pro Display Regular", size: 14, relativeTo: .title3))
                                                        .italic()
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .fontWeight(.medium)
                                                
                                            }
                                        }
                                        .padding(.leading,5)
                                        Spacer()
                                        Text("₹\(homeViewModel.cities[i].price)")
                                            .padding(.trailing)
                                    }
                                    
                                }
                            }
                                //.padding(.bottom)
                            .padding([.leading])
                                
                                
                                
                            }
                        }
                            .sheet(isPresented: $isTourDetailPresented) {
                                NavigationView{
                                    TourDetailView(tourID: $selectedTourID )
                                }
                            }
                        
                    }
                }
                    
                    
                }
                
            }
            .navigationTitle("Delhi")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        isProfileActive.toggle()
//                    } label: {
//                        Image(systemName: "person.fill")
//                            .resizable()
//                            .scaledToFill()
//                            .padding(.top,16)
//                            .frame(width: 25, height: 25)
//                        
//                    }
//                    .padding(.bottom, 16)
//                }
//            }
            

//            .sheet(isPresented: $isProfileActive) {
//                NavigationView{
//                    ProfileView()
//                }
//            }
        }
    }
        .refreshable {
            homeViewModel.getUser()
            homeViewModel.getCities()
            homeViewModel.getBookings()
        }
        .task{
            homeViewModel.getUser()
            homeViewModel.getCities()
            homeViewModel.getBookings()
        }
    }
}

//#Preview {
//    HomeView()
//}
