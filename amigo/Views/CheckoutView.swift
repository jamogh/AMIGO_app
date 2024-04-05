import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

// create a second Date instance set to one day in seconds from now
let tomorrow = Date().addingTimeInterval(604800)
// create a range from those two
let range = Date()...tomorrow

struct CheckoutView: View {
    var guideName: String = ""
    var guideID: String = ""
    var guideLocation: String = ""
    var guidePhone:String = ""
    var guideEmail:String = ""
    var guideRating:String = ""
    var guideImage: String = ""
    @StateObject var bookingViewModel = BookingViewModel()
    @StateObject var guideViewModel = GuideViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var appointmentDate = Date()
    @State private var appointmentTime = Date()
    @State private var numberAdult = 1
    @State private var numberChild = 0
    // Fixed the array declaration
    var guideLanguage: [String] = []

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
            ScrollView(){
                VStack{
                    HStack {
                        Circle()
                           .overlay(content: {
                               if(guideImage == ""){
                            Image("thailand")
                                .resizable()
                                .frame(width: 75, height: 75)
                        }
                        else{
                            let imageURL=URL(string: guideImage)
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
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(guideName)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(guideLocation)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Divider()
//
//                                Button {
//                                    print(guideLanguage)
//                                } label: {
//                                    Text("Language")
//                                }
                            
                            ForEach(guideLanguage, id: \.self) { language in
                                Text(language)
                                    .font(Font.custom("SF Pro Display Regular", size: 14, relativeTo: .title3))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.medium)
                            }
                        }
                                                    
                        Spacer()
                        
                        Text(guideRating + "⭐️")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                            .background(Color.black)
                            .cornerRadius(8)

                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 150)
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                    
                    
                    
                    Text("Booking Detail")
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
                    VStack{
                        DatePicker("Booking Date :",selection: $appointmentDate,in: range,displayedComponents: .date)
                            .font(Font.custom("SF Pro Display Regular", size: 20,relativeTo: .title2))
                            .padding()
                            .padding([.leading, .trailing])
                        DatePicker("Booking Time :",selection: $appointmentTime,in: range,displayedComponents: .hourAndMinute)
                            .font(Font.custom("SF Pro Display Regular", size: 20,relativeTo: .title2))
                            .padding()
                            .padding([.leading, .trailing])
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    )
                    Text("Travellers")
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
                    VStack{
                        Stepper("Adult : \(numberAdult)", value: $numberAdult,in: 1...5)
                        Stepper("Child : \(numberChild)", value: $numberChild,in: 0...5)
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    )
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("₹1200")
                    }
                    .padding()
                    NavigationLink(destination:OrderDetailView(guideName: guideName, guideID:guideID,guideLocation:guideLocation,guideRating:guideRating,guideLanguage:guideLanguage, appointmentTime: appointmentTime, appointmentDate: appointmentDate,numberAdult:numberAdult,numberChild:numberChild,guidePhone:guidePhone,guideEmail:guideEmail, guideImage: guideImage)){
                        Text("Confirm Booking")
                            .font(Font.custom("SF Pro Display", size: 20,relativeTo: .title2))
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.blue)
                                    .frame(width: 220, height: 48)
                            )
                    }
                    .task {
                        let bookingID = UUID().uuidString
                        let formatTime = appointmentTime.formatted(date: .omitted, time: .shortened)
                        bookingViewModel.bookingAdd(bookingID: bookingID, guideID: guideID, userID: Auth.auth().currentUser!.uid, guideName: guideName, bookingDate: appointmentDate, bookingTime: formatTime, location: guideLocation)
                        guideViewModel.specificGuideFilter(guide: guideID)
                    }
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    CheckoutView()
}

