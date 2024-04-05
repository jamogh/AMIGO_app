
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


//import SwiftUI
//
//struct BookingView: View {
//    @StateObject var homeViewModel = HomeViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(homeViewModel.booking, id: \.id) { booking in // Use homeViewModel.booking instead of bookings
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
//
//            }
//            .navigationTitle("Bookings")
//            .onAppear {
//                // Fetch booking details from Firestore
//                homeViewModel.getBookings()
//            }
//        }
//        Text("Hello")
//    }
//}
