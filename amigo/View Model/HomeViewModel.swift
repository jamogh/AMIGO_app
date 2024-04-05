//
//  HomeViewModel.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
import CoreLocation


class HomeViewModel: NSObject,ObservableObject {
    
    @Published var user = [UserProfile]()
    @Published var cities = [Cities]()
    @Published var booking = [Booking]()
    func getUser(){
        let db = Firestore.firestore()
        let collectionRef = db.collection("User Profile")
        let query = collectionRef
            .whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
        query.addSnapshotListener { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.user = snapshot.documents.map { d in
                            // Create a Todo item for each document returned
                            return UserProfile(id: d["id"] as? String ?? "", name: d["name"] as? String ?? "", phone: d["phone"] as? String ?? "", imageURL: d["imageURL"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // Handle the error
                print("Error")
            }
        }
    }
    func getCities(){
        let db = Firestore.firestore()
        let collectionRef = db.collection("Cities")
        let query = collectionRef
        query.addSnapshotListener { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.cities = snapshot.documents.map { d in
                            // Create a Todo item for each document returned
                            return Cities(id: d["id"] as? String ?? "", name: d["name"] as? String ?? "", description: d["decription"] as? String ?? "", price: d["price"] as? String ?? "", imageReferenceID: d["image"] as? String ?? "",rating: d["rating"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // Handle the error
                print("Error")
            }
        }
    }
//    func getBookings(){
//        let db = Firestore.firestore()
//        let collectionRef = db.collection("Booking")
//        let query = collectionRef.whereField("userID", isEqualTo: Auth.auth().currentUser!.uid)
//        query.addSnapshotListener { snapshot, error in
//            // Check for errors
//            if error == nil {
//                // No errors
//                if let snapshot = snapshot {
//                    // Update the list property in the main thread
//                    DispatchQueue.main.async {
//                        // Get all the documents and create Todos
//                        self.booking = snapshot.documents.map { d in
//                            // Create a Todo item for each document returned
//                            return Booking(bookingID: d["bookingID"] as? String ?? "", bookingDate: d["bookingDate"] as? Int ?? 0, bookingTime: d["bookingTime"] as? String ?? "", location: d["location"] as? String ?? "", userID: d["userID"] as? String ?? "", guideID: d["guideID"] as? String ?? "", guideName: d["guideName"] as? String ?? "")
//                        }
//                    }
//                }
//            }
//            else {
//                // Handle the error
//                print("Error")
//            }
//        }
//    }
    func getBookings(){
        let db = Firestore.firestore()
        let collectionRef = db.collection("Booking")
        
        // Check if currentUser is not nil before accessing its uid
        if let currentUser = Auth.auth().currentUser {
            let query = collectionRef.whereField("userID", isEqualTo: currentUser.uid)
            
            query.addSnapshotListener { snapshot, error in
                // Check for errors
                if error == nil {
                    // No errors
                    if let snapshot = snapshot {
                        // Update the list property in the main thread
                        DispatchQueue.main.async {
                            // Get all the documents and create Todos
                            self.booking = snapshot.documents.map { d in
                                // Create a Todo item for each document returned
                                return Booking(bookingID: d["bookingID"] as? String ?? "", bookingDate: d["bookingDate"] as? Int ?? 0, bookingTime: d["bookingTime"] as? String ?? "", location: d["location"] as? String ?? "", userID: d["userID"] as? String ?? "", guideID: d["guideID"] as? String ?? "", guideName: d["guideName"] as? String ?? "")
                            }
                        }
                    }
                }
                else {
                    // Handle the error
                    print("Error")
                }
            }
        } else {
            print("Current user is nil.")
            // Handle the scenario where the user is not authenticated, such as displaying an error message or redirecting to the login screen.
        }
    }
    
    func getCurrentBookings(completion: @escaping ([Booking]) -> Void) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("Booking")
        
        // Check if currentUser is not nil before accessing its uid
        if let currentUser = Auth.auth().currentUser {
            let query = collectionRef.whereField("userID", isEqualTo: currentUser.uid)
            
            query.addSnapshotListener { snapshot, error in
                // Check for errors
                if let error = error {
                    // Handle the error
                    print("Error fetching bookings: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                // No errors
                var bookings: [Booking] = []
                if let snapshot = snapshot {
                    // Get all the documents and create Bookings
                    for document in snapshot.documents {
                        let bookingID = document["bookingID"] as? String ?? ""
                        let bookingDate = document["bookingDate"] as? Int ?? 0
                        let bookingTime = document["bookingTime"] as? String ?? ""
                        let location = document["location"] as? String ?? ""
                        let userID = document["userID"] as? String ?? ""
                        let guideID = document["guideID"] as? String ?? ""
                        let guideName = document["guideName"] as? String ?? ""
                        
                        let booking = Booking(bookingID: bookingID, bookingDate: bookingDate, bookingTime: bookingTime, location: location, userID: userID, guideID: guideID, guideName: guideName)
                        
                        bookings.append(booking)
                    }
                }
                
                completion(bookings)
            }
        } else {
            print("Current user is nil.")
            // Handle the scenario where the user is not authenticated, such as displaying an error message or redirecting to the login screen.
            completion([])
        }
    }


    func fetchSpecificCity(tour: String){
        let db = Firestore.firestore()
        
        let collectionRef = db.collection("Cities")
        let query = collectionRef.whereField("name", isEqualTo: tour)
        
        query.addSnapshotListener { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async { [self] in
                        // Get all the documents and create Todos
                        self.cities = snapshot.documents.map { d in
                            let features: NSArray = (d["features"] as? NSArray)!
                            let stringArray = features.compactMap { $0 as? String }
                            return Cities(id: d["id"] as? String ?? "", name: d["name"] as? String ?? "", description: d["description"] as? String ?? "", price: d["price"] as? String ?? "", features: stringArray as [String], imageReferenceID: d["image"] as? String ?? "",rating: d["rating"] as? String ?? "")
                        
                            
                        }
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
}
