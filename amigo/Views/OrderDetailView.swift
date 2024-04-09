import SwiftUI
import SDWebImageSwiftUI

struct OrderDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
        
    var guideName: String = ""
    var guideID: String = ""
    var guideLocation:String = ""
    var guideRating:String = ""
    var guideLanguage:[String] = []
    var appointmentTime:Date = Date()
    var appointmentDate:Date = Date()
//    var booking: Booking
    var numberAdult = 1
    var numberChild = 0
    var guidePhone:String = ""
    var guideEmail:String = ""
    var guideImage: String = ""
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var guideModel = GuideViewModel()
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black.ignoresSafeArea()
            } else {
                Color(red: 242/255, green: 241/255, blue: 246/255).ignoresSafeArea()
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    // Guide Details Section
                    VStack(spacing: 16) {
                        // Guide Information
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
                        
                        // Contact Information
                        VStack(alignment: .leading, spacing: 8) {
                            ContactInfoRow(title: "Phone", value: guidePhone)
                            ContactInfoRow(title: "Email", value: guideEmail)
                            ContactInfoRow(title: "Meeting Point", value: guideLocation)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                        
                    }
                    
                    // Booking Details Section
                    VStack(spacing: 16) {
                        BookingDetailRow(title: "Booking Date", value: appointmentDate.formatted(date: .abbreviated, time: .omitted))
                        BookingDetailRow(title: "Booking Time", value: appointmentTime.formatted(date: .omitted, time: .shortened))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                    
                    // Number of Guests Section
                    VStack(spacing: 16) {
                        BookingDetailRow(title: "Adult", value: "\(numberAdult)")
                        BookingDetailRow(title: "Child", value: "\(numberChild)")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Order Detail")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
//                .toolbar {
//                    ToolbarItem {
//                        Button("Done") {
//                            dismiss()
//                        }
//                    }
//                }
            }
        }
        .task {
            homeViewModel.fetchSpecificCity(tour: guideLocation)
            guideModel.specificGuideFilter(guide: guideID)
        }
    }
}

struct ContactInfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct BookingDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
