//
//  EditProfileView.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State var name:String = ""
        @State var phoneNumber:String = ""
    @Environment(\.colorScheme) var colorScheme
       
    @AppStorage("showEditPage") var showEditPage: Bool = true
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
            ScrollView{
            VStack{
                if homeViewModel.user.count > 0{
                    Text("Edit Details")
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding([.horizontal, .bottom])
                    HStack{
                        Text("Name :")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding(.leading)
                        TextField(homeViewModel.user[0].name, text: $name)
                    }
                    .padding(.leading)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                            .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding([.leading,.trailing,.bottom])
                    
                    HStack{
                        Text("Phone Number :")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding(.leading)
                        TextField(homeViewModel.user[0].phone, text: $phoneNumber)
                    }
                    .padding(.leading)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                            .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    }
                    
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding()
                    .padding(.bottom,40)
                    Button{
                        //editProfile.editUser(name: name, phone: phoneNumber)
                        
                        showEditPage.toggle()
                    }label: {
                        Text("Update Details")
                            .font(Font.custom("SF Pro Display", size: 17))
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 280,height: 48)
                                
                            }
                        
                    }
                    .padding(.top)
                }
                Spacer()
            }
        }
            }
            .task {
//                homeViewModel.getUser()
//                getDogvm.getDog()
            }
    }
}

#Preview {
    EditProfileView()
}
