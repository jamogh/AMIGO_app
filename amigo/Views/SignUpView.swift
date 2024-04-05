//
//  SignUpView.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import PhotosUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    // @State var photoItem: PhotosPickerItem
    @StateObject var homeViewModel = HomeViewModel()
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @State var pageState: String = "LoginView"
    @State var email: String = ""
    @State var password: String = ""
    @State var setVisible: Bool = false
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State private var date = Date()
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    @State var bgColour: Color = Color(red: 242/255, green: 242/255, blue: 242/255)
    @StateObject var signup = SignUpViewModel()
    @AppStorage("usersignIn") var userIsSignIn: Bool = false
    @AppStorage("usersignUp") var userIsSignUp: Bool = false
    @AppStorage("userID") var userID: String = ""
    @AppStorage("userImageURL") var userImageURL: String = ""
    @State var showLoading: Bool = false
    
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
            if showLoading{
                Spacer()
                ProgressView()
                Spacer()
            }
            ScrollView{
                VStack{
                    
                    Text("Welcome To Amigo")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                    Text("Signup")
                        .font(.system(size: 36))
                        .fontWeight(.black)
                    
                    VStack(spacing:20){
                        
                        VStack{
                            
                            Button {
                                showImagePicker.toggle()
                            } label: {
                                VStack{
                                    VStack {
                                        if let image = self.image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 128, height: 128)
                                                .cornerRadius(64)
                                        } else {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 64))
                                                .padding()
                                                .foregroundColor(Color.black)
                                        }
                                        
                                    }
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 64)
                                            .stroke(Color.black, lineWidth: 3)
                                            .background(.clear)
                                    }
                                    
                                    Text("Choose Profile Image")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }.padding()
                            
                            
                            TextField("Enter Your Email", text : $email)
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
                                            .textContentType(.newPassword)
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
                            
                            TextField("Enter Your Name", text : $name)
                                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                .disableAutocorrection(true)
                                .font(Font.custom("SF Pro Display", size: 17))
                                .padding(.leading, 30)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                }
                                .padding(.bottom)
                            
                            TextField("Phone Number", text : $phoneNumber)
                                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                .keyboardType(.phonePad)
                                .font(Font.custom("SF Pro Display", size: 17))
                                .disableAutocorrection(true)
                                .padding(.leading, 30)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(colorScheme == .dark ? Color(red: 44/255, green: 44/255, blue: 46/255) : .white)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                }
                            
                            Button{
                                completeSignUp()
                                dismiss()
                                homeViewModel.getUser()
                            }label: {
                                Text("Sign Up")
                                    .font(Font.custom("SF Pro Display", size: 20))
                                    .foregroundStyle(Color.white)
                                    .bold()
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(Color.black)
                                            .frame(width: 220, height: 48)
                                        
                                    )
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 3)
                                            .frame(width: 220, height: 48)
                                    }
                                
                            }
                            
                            .padding([.top], 16)
                            
                            Text("Or continue with")
                            
                            HStack{
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
                                Image("apple")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45)
                                    .padding(8)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 1)
                                    }
                            }
//                            Text("Already have an account? LOGIN")
                            HStack(spacing:5){
                                Text("Already have an account?")
                                Button(action:{
                                    withAnimation{
                                        pageState = "LoginView"
                                    }
                                }){
                                    Text("LOGIN")
                                        .font(.system(size: 17,weight: .bold))
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                    }
                    
                }
                .overlay(content: {
                    
                    if showLoading{
                      LoadingView(show: $showLoading)
                            .ignoresSafeArea()
                    }
                        
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"),message: Text(alertMessage))
                }
                .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                    ImagePickerView(image: $image)
                }
            }
            
   
        }
        .toolbar {
            ToolbarItem {
                Button("Skip"){
                    if userIsSignIn{
                        dismiss()
                    }
                    else{
                        userIsSignIn.toggle()
                    }
                    

                }
            }
        }
    }
    func completeSignUp(){
        Task{
            
            do {
                if(self.email != "" && self.password != ""){
                    if(isValidEmail(self.email) && isValidPassword(self.password) && isValidPhoneNumber(phoneNumber) && name != ""){
                        
                        try await Auth.auth().createUser(withEmail: email, password: password)
                        self.showLoading = true
                        guard let id = Auth.auth().currentUser?.uid else {return}
                        let imageReferenceID = "\(id)"
                        let storageRef = Storage.storage().reference().child("UserProfile_Images").child(imageReferenceID)
                        if let imageData = self.image?.jpegData(compressionQuality: 0.5) {
                            let _ = try await storageRef.putDataAsync(imageData)
                            let downloadURL = try await storageRef.downloadURL()
                            signup.registerUser(id: id,name: name, phone: (phoneNumber), imageURL: downloadURL.absoluteString)
                            print("Sign up successful")
                            userIsSignIn = true
                            userIsSignUp = true
                            userID = Auth.auth().currentUser!.uid
                            userImageURL = downloadURL.absoluteString
                            print(userID)
                            print(userImageURL)
                            
                        }
                        
                        else {
                            self.showLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                signup.registerUser(id: id,name: name, phone: (phoneNumber), imageURL: "")
                                print("Sign up successful")
                                userIsSignIn = true
                                userIsSignUp = true
                                userID = Auth.auth().currentUser!.uid
                            }
                            
                        }
                    }
                    else if(!isValidEmail(self.email)) {
                        print("Invalid Email Address")
                        self.alertMessage = "Invalid Email Address"
                        self.showAlert.toggle()
                    }
                    else if(!isValidPassword(self.password)) {
                        print("Password should contain minimum 8 characters. It should have atleast one lowercase letter, one uppercase letter and a number.")
                        self.alertMessage = "Password should contain minimum 8 characters. It should have atleast one lowercase letter, one uppercase letter and a number."
                        self.showAlert.toggle()
                    }
                    else if(!isValidPhoneNumber(phoneNumber)){
                        print("Invalid Phone Number")
                        self.alertMessage = "Invalid Phone Number"
                        self.showAlert.toggle()
                    }
                    else if(name == ""){
                        print("The name field is empty")
                        self.alertMessage = "The name field is empty"
                        self.showAlert.toggle()
                    }
                }
                else  {
                    print("Email or Password Field Is Empty")
                    self.alertMessage = "Email or Password Field Is Empty"
                    self.showAlert.toggle()
                }
            }
            
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$", options: [])
        return regex.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.utf16.count)) != nil
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#, options: [])
        return regex.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.utf16.count)) != nil
    }
    
}

#Preview {
    SignUpView()
}
