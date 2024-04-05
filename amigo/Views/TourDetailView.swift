//
//  TourDetailView.swift
//  amigo
//
//  Created by Amogh on 06/03/24.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct TourDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var homeViewModel = HomeViewModel()
    @Binding var tourID : String
    @State private var guideFilter:String = ""
    @Environment(\.dismiss) private var dismiss
    

    var body: some View {
        
            ZStack{
                if(colorScheme == .dark){
                    Color.black
                        .ignoresSafeArea()
                }
                else{
                    Color(red: 242/255, green: 241/255, blue: 246/255)
                        .ignoresSafeArea()
                }
                
                ScrollView(showsIndicators: false){
                    if(homeViewModel.cities.count>0){
                        VStack{
                            VStack(alignment:.leading){
                                Text(homeViewModel.cities[0].name)
                                    .fontWeight(.bold)
                                HStack{
                                    Text("⭐️(\(homeViewModel.cities[0].rating))")
                                    Spacer()
                                    Text("📍\(homeViewModel.cities[0].name)")
                                    Spacer()
                                    Text("₹\(homeViewModel.cities[0].price)")
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                )
                                .padding(.horizontal)
                                if(homeViewModel.cities[0].imageReferenceID == ""){
                                    Image("thailand")
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .scaledToFill()
                                }
                                else{
                                    let imageURL=URL(string: homeViewModel.cities[0].imageReferenceID)
                                    WebImage(url: imageURL!)
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .scaledToFill()
                                    
                                }
                                Text("About Tour detail")
                                    .fontWeight(.bold)
                                Text(homeViewModel.cities[0].description)
                                
//                                ForEach(homeViewModel.cities[0].features, id: \.self) { language in
//                                    VStack {
//                                        
//                                        Spacer() // Add spacer to push Text(language) to the trailing edge
//                                        Text(language)
//                                            .font(Font.custom("SF Pro Display Regular", size: 14, relativeTo: .title3))
//                                            .italic()
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .fontWeight(.medium)
//                                    }
//                                }
                                
                            }
                            .padding()
                            NavigationLink(destination: GuideListView(locationOfGuide: $guideFilter)){
                            Text("Book")
                                .font(Font.custom("SF Pro Display", size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 220, height: 48)
                                    
                                )
                             /*   .overlay{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.green, lineWidth: 3)
                                        .frame(width: 220, height: 48)
                                } */
                        }
                            .task {
                                guideFilter = homeViewModel.cities[0].name
                            }
                        }
                    }
                }
                .navigationTitle("Tour Detail")
                .navigationBarTitleDisplayMode(.inline)
               /* .toolbar {
                    ToolbarItem {
                        Button("Done"){
                                     dismiss()
                            
            
                        }
                        
                    }
                }*/
            }
            .task {
            homeViewModel.fetchSpecificCity(tour: tourID)
            }
    }
}

