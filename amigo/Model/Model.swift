//
//  Model.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//

import UIKit
import Firebase
import Foundation
import CoreLocation
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift


struct User{
    var userID : UUID
    var userProfile:UserProfile?
    init(userID: UUID, userProfile: UserProfile? = nil) {
        self.userID = userID
        self.userProfile = userProfile
    }
}

struct UserProfile{
    var id: String
    var name: String
    var phone: String
    var imageURL: String?
 
}

struct Cities: Identifiable, Hashable{
    var id: String
    var name: String
    var description: String
    var price:String
    var features: [String] = []
    var imageURL: URL?
    var imageReferenceID: String = ""
    var rating: String = ""
}

struct Guide:Identifiable, Hashable{
    var id:String
    var guideID:String
    var name:String
    var phone:String
    var email:String
    var location:String
    var rating:String
    var language: [String]
    var imageURL: URL?
    var imageReferenceID: String = ""
    
}

struct Booking: Codable, Identifiable, Hashable{
    @DocumentID var id:String?
    var bookingID:String?
    var bookingDate:Int
    var bookingTime:String
    var location : String
    var userID:String
    var guideID:String
    var guideName:String
}
