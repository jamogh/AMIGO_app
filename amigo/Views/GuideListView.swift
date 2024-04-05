//
//  GuideListView.swift
//  amigo
//
//  Created by Amogh on 18/03/24.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct GuideListView: View {
    @StateObject var model = GuideViewModel()
    @Binding var locationOfGuide: String
    @State var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
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

                ForEach(searchResults, id: \.self){ d in
                    
                    NavigationLink(destination:CheckoutView(guideName: d.name,guideID: d.guideID, guideLocation: d.location, guidePhone: d.phone, guideEmail: d.email, guideRating: d.rating, guideImage: d.imageReferenceID, guideLanguage: d.language)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 165)
                                .foregroundColor(Color(.white))
                                .padding([.leading,.trailing])
                            
                            
                            VStack{
                                HStack{
                                    Circle()
                                        .overlay(content: {
                                            if(d.imageReferenceID == ""){
                                                Image("thailand")
                                                    .resizable()
                                                    .frame(width: 75, height: 75)
                                            }
                                            else{
                                                let imageURL=URL(string: d.imageReferenceID)
                                                WebImage(url: imageURL!)
                                                    .resizable()
//                                                    .frame(width: 10, height: 10)
                                                    .overlay{
                                                          Circle()
                                                            .stroke(Color.blue, lineWidth: 4)
//                                                           .frame(width: 220, height: 48)
                                                      }
                                                    .clipShape(Circle())
                                                    .scaledToFill()
                                            }
                                              
                                        })
                                        .frame(width: 90)
                                        .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                                        .padding()
                                    VStack{
                                        Text(d.name)
                                            .font(Font.custom("SF Pro Display Bold",size: 20,relativeTo: .title2))
                                            .frame(maxWidth: .infinity,alignment:.leading)
                                            .padding([.top],16)
                                        
                                        Text(d.location)
                                            .font(Font.custom("SF Pro Display Semibold",size: 15,relativeTo: .title3))
                                            .frame(maxWidth: .infinity,alignment:.leading)
                                        Divider()
//                                        HStack{
//                                            ForEach(d.language, id: \.self) { language in
//                                                Text(language)
//                                                    .font(Font.custom("SF Pro Display Regular", size: 16, relativeTo: .title3))
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .fontWeight(.medium)
////                                                    .multilineTextAlignment(.trailing)
//                                            }
//                                        }
                                        
                                        ForEach(d.language, id: \.self) { language in
                                            VStack {
                                                
//                                                Spacer() // Add spacer to push Text(language) to the trailing edge
                                                Text(language)
                                                    .font(Font.custom("SF Pro Display Regular", size: 14, relativeTo: .title3))
                                                    .italic()
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fontWeight(.medium)
                                            }
                                        }
                                        
                                        HStack{
                                            Image("verify")
                                                .resizable()
                                                .clipShape(Circle())
                                                .frame(width: 20, height: 20, alignment: .leading)
                                            Spacer()
                                            Text("Verified")
                                                .font(Font.custom("SF Pro Display Semibold",size: 15,relativeTo: .title3))
                                                .frame(maxWidth: .infinity,alignment:.leading)
                                        }
                                        
//                                        .padding()
                                        
//                                        Text(d.language)
//                                            .font(Font.custom("SF Pro Display Regular",size: 16,relativeTo: .title3))
//                                            .frame(maxWidth: .infinity,alignment:.leading)
//                                            .fontWeight(.medium)
//                                            .multilineTextAlignment(.leading)
//                                        Spacer()
                                    }
                                    .foregroundColor(Color.black)
                                    .padding(.top)
                                    Spacer()
                                    VStack{
                                        Text("\(d.rating)⭐️")
                                            .font(Font.custom("SF Pro Display Medium",size: 16,relativeTo: .title3))
                                            .foregroundColor(.white)
                                            .fontWeight(.medium)
                                            .padding(.top,16)
                                            .padding(.trailing)
                                            .background{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width:45,height: 30)
                                                    .foregroundColor(Color.black)
                                                    .padding(.top,16)
                                                    .padding(.trailing)
                                                
                                            }
                                        
                                    }.padding(.bottom)
                                    
                                }
                                .padding([.leading,.trailing])
                            }
                        }
                        .padding(.top)
                    }
                }
            }
      /*      .toolbar {
                ToolbarItem {
                    Button("Done"){
                     dismiss()
                    }
                }
            }*/
            .navigationTitle("Guides")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
        }.task{
            model.GuideFilter(guide: locationOfGuide)
        }
    }
    var searchResults: [Guide] {
        if searchText.isEmpty {
            return model.guide
        } else {
            return model.guide.filter {$0.name.contains(searchText) }
        }
        
    }
}


