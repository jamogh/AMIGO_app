//
//  BookingViewModel.swift
//  amigo
//
//  Created by Amogh on 19/03/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
import CoreLocation

class BookingViewModel: NSObject,ObservableObject{
    func bookingAdd(bookingID: String,guideID: String, userID: String, guideName: String,bookingDate: Date,bookingTime: String,location:String){
        let db = Firestore.firestore()
        let uuid = UUID().uuidString
        print(uuid)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.full
        let dateString = dateFormatter.string(from: bookingDate)
        let date = dateFormatter.date(from: dateString)!
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = 9
        components.minute = 30
        
        print(components)
        
        let updatedDate = calendar.date(from: components)!
        let updatedDateString = dateFormatter.string(from: updatedDate)
        print(updatedDateString)
        
        var timeStamp :Int = 0
        
        if let fdate = dateFormatter.date(from: updatedDateString) {
            timeStamp = Int(fdate.timeIntervalSince1970)
            
        }
        db.collection("Booking").document(bookingID).setData(["bookingID": bookingID,
                                                 "bookingDate": timeStamp,
                                                 "guideID": guideID,
                                                 "userID": userID,
                                                 "guideName": guideName,
                                                 "location":location,
                                                 "bookingTime":bookingTime]) { error in
            if (error != nil){
                print(error!)
            }
        }
        
    }
}
