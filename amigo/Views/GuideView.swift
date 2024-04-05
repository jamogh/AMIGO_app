//
//  GuideView.swift
//  amigo
//
//  Created by Amogh on 06/03/24.
//

import SwiftUI

struct GuideView: View {
    @State var searchText = ""
    @State var customBlue:CGColor = CGColor(red: 0.139, green: 0.561, blue: 0.996, alpha: 1)
    var ratingSegue :Float = 0.0
    @Environment(\.colorScheme) var colorScheme
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
              //  NavigationLink() {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 120)
                            .foregroundColor(Color(.white))
                        
                            .padding([.leading,.trailing])
                        
                        // .shadow(color: Color("purple.accent.color"), radius: 1, x: -3, y: 3)
                        
                        VStack{
                            HStack{
                                Circle()
                                    .overlay(content: {
                                        Image("person")
                                            .resizable()
                                            .frame(width: 75, height: 75)
                                    })
                                    .frame(width: 90)
                                    .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                                    .padding()
                                VStack{
                                    Text("Name")
                                        .font(Font.custom("SF Pro Display Bold",size: 20,relativeTo: .title2))
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                        .padding([.top],16)
                                   
                                    
                                    Text("New Delhi")
                                        .font(Font.custom("SF Pro Display Regular",size: 16,relativeTo: .title3))
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text("English,French")
                                        .font(Font.custom("SF Pro Display Semibold",size: 15,relativeTo: .title3))
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                Spacer()
                                VStack{
                                    Text("⭐️⭐️")
                                        .font(Font.custom("SF Pro Display Medium",size: 16,relativeTo: .title3))
                                        .foregroundColor(.white)
                                        .fontWeight(.medium)
                                        .padding(.top,16)
                                        .padding(.trailing)
                                        .background{
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width:40,height: 30)
                                                .foregroundColor(Color("graypurple.accent.color"))
                                                .padding(.top,16)
                                                .padding(.trailing)
                                            
                                        }
                                    
                                }.padding(.bottom)
                                
                            }
                            .padding([.leading,.trailing])
                            
                            
                        }
                        
                    }
                    .padding(.top)
                //}
                
            }
            .navigationTitle("Select Guide")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
        }
    }

}

#Preview {
    GuideView()
}


