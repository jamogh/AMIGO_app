//
//
//
//
//
//import SwiftUI
//import Firebase // Import Firebase
//
//struct BookingView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: PastTripsView()) {
//                    Text("Past Trips")
//                        .foregroundColor(.black)
//                        .font(.title)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 20)
//                
//                NavigationLink(destination: UpcomingTripsView()) {
//                    Text("Upcoming Trips")
//                        .foregroundColor(.black)
//                        .font(.title)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.green)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal, 20)
//            }
//            .navigationTitle("Bookings")
//        }
//        .onAppear {
//            // Fetch booking details from Firestore
//            fetchBookingDetails()
//        }
//    }
//    
//    func fetchBookingDetails() {
//        // Fetch booking details from Firestore
//        // Example: Firestore.firestore().collection("bookings").getDocuments { (querySnapshot, error) in
//        //     guard let documents = querySnapshot?.documents else {
//        //         print("Error fetching documents: \(error)")
//        //         return
//        //     }
//        //     for document in documents {
//        //         let data = document.data()
//        //         // Process booking details here
//        //     }
//        // }
//    }
//}
//
//struct PastTripsView: View {
//    var body: some View {
//        Text("Past Trips")
//            .font(.title)
//            .padding()
//    }
//}
//
//struct UpcomingTripsView: View {
//    var body: some View {
//        Text("Upcoming Trips")
//            .font(.title)
//            .padding()
//    }
//}
//
//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//}
//
//


//
//import SwiftUI
//import Firebase // Import Firebase
//
//struct BookingView: View {
//    @StateObject var bookingViewModel = HomeViewModel()
//    @State private var bookings: [Booking] = []
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(bookings, id: \.id) { booking in
//                    NavigationLink(destination: OrderDetailView(booking: booking)) {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Guide: \(booking.guideName)")
//                                .font(.headline)
//                            Text("Location: \(booking.location)")
//                                .font(.subheadline)
//                            Text("Date: \(booking.bookingDate.formatted(date: .abbreviated, time: .omitted))")
//                                .font(.subheadline)
//                            Text("Time: \(booking.bookingTime)")
//                                .font(.subheadline)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Bookings")
//            .onAppear {
//                // Fetch booking details from Firestore
//                fetchBookingDetails()
//            }
//        }
//    }
//    
//    func fetchBookingDetails() {
//        bookingViewModel.getCurrentBookings { fetchedBookings in
//            self.bookings = fetchedBookings
//        }
//    }
//}
//
//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//}
