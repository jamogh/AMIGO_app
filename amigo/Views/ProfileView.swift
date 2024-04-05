
import SwiftUI
import Firebase
import FirebaseAuth
import SDWebImageSwiftUI

struct ProfileView: View {
    @AppStorage("usersignIn") var userIsSignIn: Bool = true
    @AppStorage("showEditPage") var showEditPage: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @StateObject var homeViewModel = HomeViewModel()
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
               
                if homeViewModel.user.count > 0 {
                    
                    NavigationLink(destination: EditProfileView()) {
                        ScrollView(showsIndicators:false){
                        if(homeViewModel.user[0].imageURL == ""){
                            
                            VStack(spacing: 8) {
                                WebImage(url: URL(string: homeViewModel.user[0].imageURL!))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                    
                                VStack(alignment: .leading,spacing: 8) {
                                    Text(homeViewModel.user[0].name)
                                        .font(Font.custom("SF Pro Display Regular",size: 16))
                                    Text(homeViewModel.user[0].phone)
                                        .font(Font.custom("SF Pro Display Light",size: 14))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(.horizontal, 16)
                            .frame(width: UIScreen.main.bounds.width-32, height: 80, alignment: .leading)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 65)
                                    .foregroundColor(Color(.white))
                            )
                        }
                        else{
                            HStack(spacing: 8) {
                                WebImage(url: URL(string: homeViewModel.user[0].imageURL!))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                VStack(alignment: .leading,spacing: 8) {
                                    Text(homeViewModel.user[0].name)
                                        .font(Font.custom("SF Pro Display Regular",size: 16))
                                    Text(homeViewModel.user[0].phone)
                                        .font(Font.custom("SF Pro Display Light",size: 14))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal, 16)
                            .frame(width: UIScreen.main.bounds.width-32, height: 80, alignment: .leading)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 65)
                                    .foregroundColor(Color(.white))
                            )
                            }
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 65)
                                .foregroundColor(Color(.white))
                            //                    .shadow(color: Color("purple.accent.color"), radius: 1, x: -5, y: 5)
                                .overlay {
                                    Button(action: logOutUser) {
                                        HStack(spacing: 8) {
                                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("Logout")
                                                .font(Font.custom("SF Pro Display Regular",size: 16))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .foregroundColor(Color.red)
                                        .padding(.horizontal, 16)
                                    }
                                    
                                }
                                .padding(.horizontal, 16)
                        }
                    }
                    
                }
                
            }
            .padding(.vertical, 8)
            .padding(.bottom, 8)
            .refreshable {
                homeViewModel.getUser()
            }
            .task {
                homeViewModel.getUser()
            }
    }
    func logOutUser(){
        try? Auth.auth().signOut()
        print("User logged out")
        userIsSignIn.toggle()
    }
}

#Preview {
    ProfileView()
}


//import SwiftUI
//import Firebase
//import FirebaseAuth
//import SDWebImageSwiftUI
//
//struct ProfileView: View {
//    @AppStorage("usersignIn") var userIsSignIn: Bool = true
//    @AppStorage("showEditPage") var showEditPage: Bool = false
//    @Environment(\.colorScheme) var colorScheme
//    @StateObject var homeViewModel = HomeViewModel()
//
//    var body: some View {
//        ZStack {
//            if colorScheme == .dark {
//                Color.black
//                    .ignoresSafeArea()
//            } else {
//                Color(red: 242/255, green: 241/255, blue: 246/255)
//                    .ignoresSafeArea()
//            }
//            
//            VStack(spacing: 20) {
//                if homeViewModel.user.count > 0 {
//                    NavigationLink(destination: EditProfileView()) {
//                        VStack(spacing: 8) {
//                            if homeViewModel.user[0].imageURL == "" {
//                                HStack(spacing: 8) {
//                                    Image(systemName: "person.circle")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundColor(.primary)
//                                    
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(homeViewModel.user[0].name)
//                                            .font(.headline)
//                                        
//                                        Text(homeViewModel.user[0].phone)
//                                            .font(.subheadline)
//                                            .foregroundColor(.secondary)
//                                    }
//                                }
//                            } else {
//                                WebImage(url: URL(string: homeViewModel.user[0].imageURL!))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(Circle())
//                                
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(homeViewModel.user[0].name)
//                                        .font(.headline)
//                                    
//                                    Text(homeViewModel.user[0].phone)
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .shadow(radius: 3)
//                    }
//                }
//
//                Spacer()
//
//                Button(action: logOutUser) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "rectangle.portrait.and.arrow.forward")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                        
//                        Text("Logout")
//                            .font(.headline)
//                    }
//                    .foregroundColor(.red)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .shadow(radius: 3)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            homeViewModel.getUser()
//        }
//    }
//
//    func logOutUser() {
//        try? Auth.auth().signOut()
//        print("User logged out")
//        userIsSignIn.toggle()
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


//import SwiftUI
//import Firebase
//import FirebaseAuth
//import SDWebImageSwiftUI
//
//struct UserProfilee {
//    var id: String
//    var name: String
//    var phone: String
//    var imageURL: String?
//    var email: String // Added email property
//}
//
//struct ProfileView: View {
//    @AppStorage("usersignIn") var userIsSignIn: Bool = true
//    @AppStorage("showEditPage") var showEditPage: Bool = false
//    @Environment(\.colorScheme) var colorScheme
//    @StateObject var homeViewModel = HomeViewModel()
//
//    var body: some View {
//        ZStack {
//            if colorScheme == .dark {
//                Color.black
//                    .ignoresSafeArea()
//            } else {
//                Color(red: 242/255, green: 241/255, blue: 246/255)
//                    .ignoresSafeArea()
//            }
//            
//            VStack(spacing: 20) {
//                if homeViewModel.user.count > 0 {
//                    NavigationLink(destination: EditProfileView()) {
//                        VStack(spacing: 8) {
//                            if homeViewModel.user[0].imageURL == "" {
//                                HStack(spacing: 8) {
//                                    Image(systemName: "person.circle")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundColor(.primary)
//                                    
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(homeViewModel.user[0].name)
//                                            .font(.headline)
//                                        
//                                        Text(homeViewModel.user[0].phone)
//                                            .font(.subheadline)
//                                            .foregroundColor(.secondary)
//                                    }
//                                }
//                            } else {
//                                WebImage(url: URL(string: homeViewModel.user[0].imageURL!))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(Circle())
//                                
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(homeViewModel.user[0].name)
//                                        .font(.headline)
//                                    
//                                    Text(homeViewModel.user[0].phone)
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                            
//                            // Display email if available
//                            Text(homeViewModel.user[0].email)
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .shadow(radius: 3)
//                    }
//                }
//
//                Spacer()
//
//                Button(action: logOutUser) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "rectangle.portrait.and.arrow.forward")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                        
//                        Text("Logout")
//                            .font(.headline)
//                    }
//                    .foregroundColor(.red)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .shadow(radius: 3)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            homeViewModel.getUser()
//        }
//    }
//
//    func logOutUser() {
//        try? Auth.auth().signOut()
//        print("User logged out")
//        userIsSignIn.toggle()
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

//import SwiftUI
//import Firebase
//import FirebaseAuth
//import SDWebImageSwiftUI
//
//struct ProfileView: View {
//    @AppStorage("usersignIn") var userIsSignIn: Bool = true
//    @AppStorage("showEditPage") var showEditPage: Bool = false
//    @Environment(\.colorScheme) var colorScheme
//    @StateObject var homeViewModel = HomeViewModel()
//
//    var body: some View {
//        ZStack {
//            if colorScheme == .dark {
//                Color.black
//                    .ignoresSafeArea()
//            } else {
//                Color(red: 242/255, green: 241/255, blue: 246/255)
//                    .ignoresSafeArea()
//            }
//            
//            VStack(spacing: 20) {
//                if homeViewModel.user.count > 0 {
//                    NavigationLink(destination: EditProfileView()) {
//                        VStack(spacing: 8) {
//                            if homeViewModel.user[0].imageURL == "" {
//                                HStack(spacing: 8) {
//                                    Image(systemName: "person.circle")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundColor(.primary)
//                                    
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(homeViewModel.user[0].name)
//                                            .font(.headline)
//                                        
//                                        Text(homeViewModel.user[0].phone)
//                                            .font(.subheadline)
//                                            .foregroundColor(.secondary)
//                                    }
//                                }
//                            } else {
//                                WebImage(url: URL(string: homeViewModel.user[0].imageURL!))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(Circle())
//                                
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(homeViewModel.user[0].name)
//                                        .font(.headline)
//                                    
//                                    Text(homeViewModel.user[0].phone)
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .shadow(radius: 3)
//                    }
//                }
//
//                Spacer()
//
//                Button(action: logOutUser) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "rectangle.portrait.and.arrow.forward")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                        
//                        Text("Logout")
//                            .font(.headline)
//                    }
//                    .foregroundColor(.red)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .shadow(radius: 3)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            homeViewModel.getUser()
//        }
//    }
//
//    func logOutUser() {
//        try? Auth.auth().signOut()
//        print("User logged out")
//        userIsSignIn.toggle()
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
