//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import SDWebImageSwiftUI
//
//struct BookingView: View {
//    @StateObject var homeViewModel = HomeViewModel()
//    @StateObject var guideViewModel = GuideViewModel()
//    var guideID: String = "" // Assign guide ID here
//
//    var body: some View {
//        NavigationView {
//            List {
//                // Your existing bookings list here
//                
//                // Display guide bookings fetched from ViewModel
//                ForEach(guideViewModel.guideSpecific, id: \.id) { guideBooking in
//                    VStack(alignment: .leading) {
//                        Text("Guide Booking ID: \(guideBooking.bookingID)")
//                        Text("Booking Date: \(guideBooking.bookingDate)")
//                        Text("Booking Time: \(guideBooking.bookingTime)")
//                        // Add more details as needed
//                    }
//                }
//            }
//            .navigationTitle("Bookings")
//            .onAppear {
//                // Fetch user's bookings
//                homeViewModel.getBookings()
//                
//                // Fetch guide bookings
//                guideViewModel.fetchGuideBookings(guideID: guideID){
//                    guideBookings in
//                }
//            }
//        }
//    }
//}
