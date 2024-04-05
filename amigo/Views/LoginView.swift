//
//  LoginView.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//

import SwiftUI
import FirebaseAuth
import Foundation
import Firebase
import LocalAuthentication

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var email: String = ""
    @State var password: String = ""
    @State var setVisible: Bool = false
   // @StateObject var loginViewModel = LogInViewModel()
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    // Keychain Property
    // @KeyChainPropertyWrapper()
    @AppStorage("usersignIn") var userIsSignIn: Bool = false
    @AppStorage("userID") var userID: String = ""
    @AppStorage("userImageURL") var userImageURL: String = ""
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
                VStack {
                    Text("Amigo")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Text("Login")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                    
                    ZStack{
                        VStack{
                            Spacer()
                            TextField("Enter your Email", text : $email)
                                .autocapitalization(.none)
                            
                                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                .disableAutocorrection(true)
                            
                                .font(Font.custom("SF Pro Display", size: 17))
                                .padding(.leading, 30)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                }
                            
                            VStack{
                                HStack(spacing: 16) {
                                    if setVisible {
                                        TextField("Enter your Password", text : $password)
                                            .disableAutocorrection(true)
                                            .font(Font.custom("SF Pro Display", size: 17))
                                            .padding(16)
                                            .padding(.leading, 16)
                                    }
                                    else {
                                        SecureField("Enter your Password", text : $password)
                                            .disableAutocorrection(true)
                                            .font(Font.custom("SF Pro Display", size: 17))
                                            .padding(16)
                                            .padding(.leading, 16)
                                    }
                                    
                                    Button {
                                        setVisible.toggle()
                                    } label: {
                                        Image(systemName: setVisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(.gray)
                                            .padding(25)
                                    }
                                }
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                }
                                
                            }
                            
                            HStack {
                                Button {
                                    resetPassword(email: email)
                                } label: {
                                    Text("Forgot Password?")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .opacity(0.9)
                                        .foregroundColor(.black)
                                        .padding(.leading, 230)
                                }
                                
                            }
                            Button {
                                verifyUser(email: email, password: password)
                                
                            } label: {
                                Text("Log In")
                                    .font(Font.custom("SF Pro Display", size: 20))
                                    .bold()
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 220, height: 48)
                                        
                                    )
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 3)
                                            .frame(width: 220, height: 48)
                                    }
                            }
                            .padding(6)
                          
                            
                            Text("Or continue with")
                            HStack{
                                Button {
                                    
                                } label: {
                                    Image("google")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45)
                                        .padding(8)
                                        .background{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 1)
                                        }
                                        .padding(.trailing)
                                }
                                
                                Button {
                                    
                                } label: {
                                    
                                    Image("apple")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45, height: 45)
                                        .padding(8)
                                        .background{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 1)
                                        }
                                }
                            }
                            .padding(6)
                            Text("Don't have an account? SIGN UP")
                            Spacer()
                        }
                        
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"),message: Text(alertMessage))
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Skip"){
                    userIsSignIn.toggle()
                    
                }
            }
        }
    }
    func verifyUser(email: String, password: String){
        
        if(self.email != "" && self.password != ""){
            Auth.auth().signIn(withEmail: email, password: password){ result, error in
                guard let userID = Auth.auth().currentUser?.uid else {return}
                print(userID)
                
                if(error != nil){
                    print(error?.localizedDescription)
                    self.alertMessage = error!.localizedDescription
                    self.showAlert.toggle()
                    return
                }
                self.alertMessage = "Login Successful"
                self.showAlert.toggle()
                userIsSignIn.toggle()
            }
        }
        else  {
            self.alertMessage = "Invalid Email or Password"
            self.showAlert.toggle()
        }
    }
    
    func resetPassword(email: String){
        
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: email){ error in
                
                if(error != nil){
                    print(error?.localizedDescription)
                    self.alertMessage = error!.localizedDescription
                    self.showAlert.toggle()
                    return
                }
                self.alertMessage = "The link to reset your password has been sent to your email address."
                self.showAlert.toggle()
            }
        }
        else{
            self.alertMessage = "Email Id Is Empty!"
            self.showAlert.toggle()
        }
    }
}

#Preview {
    LoginView()
}
