//
//  GuideViewModel.swift
//  amigo
//
//  Created by Amogh on 18/03/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
import CoreLocation

class GuideViewModel: NSObject,ObservableObject{
    @Published var guide = [Guide]()
    @Published var guideSpecific = [Guide]()
    func GuideFilter(guide: String){
        let db = Firestore.firestore()
        
        let collectionRef = db.collection("Guide")
        let query = collectionRef
            .whereField("location", isEqualTo: guide)
        query.getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.guide = snapshot.documents.map { d in
                            let languages: NSArray = d["language"] as! NSArray
                            let stringArray = languages.compactMap { $0 as? String }
                            // Create a Todo item for each document returned
                            return Guide(id: d["id"] as? String ?? "" ,guideID: d["guideID"] as? String ?? "", name: d["name"] as? String ?? "", phone: d["phone"] as? String ?? "", email: d["email"] as? String ?? "", location: d["location"] as? String ?? "", rating: d["rating"] as? String ?? "", language: stringArray as [String] , imageReferenceID: d["image"] as? String ?? "")
                            
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
    
    func specificGuideFilter(guide: String){
        let db = Firestore.firestore()
        
        let collectionRef = db.collection("Guide")
        let query = collectionRef
            .whereField("guideID", isEqualTo: guide)
        query.getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.guideSpecific = snapshot.documents.map { d in
                            let languages: NSArray = d["language"] as! NSArray
                            let stringArray = languages.compactMap { $0 as? String }
                            // Create a Todo item for each document returned
                            return Guide(id: d["id"] as? String ?? "" ,guideID: d["guideID"] as? String ?? "", name: d["name"] as? String ?? "", phone: d["phone"] as? String ?? "", email: d["email"] as? String ?? "", location: d["location"] as? String ?? "", rating: d["rating"] as? String ?? "", language: stringArray as [String] , imageReferenceID: d["image"] as? String ?? "")
                            
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
    
    
}

