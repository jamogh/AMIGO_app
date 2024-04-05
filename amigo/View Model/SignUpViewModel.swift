//
//  SignUpViewModel.swift
//  amigo
//
//  Created by Amogh on 13/03/24.
//

import SwiftUI
import Foundation
import FirebaseSharedSwift
import FirebaseFirestore

final class SignUpViewModel: ObservableObject{
    
    func registerUser(id: String,name: String, phone: String, imageURL: String?){
        let db = Firestore.firestore()
        db.collection("User Profile").document(id).setData(["id": id,
                                                            "name" : name,
                                                            "phone" : phone,
                                                            "imageURL" : imageURL ])
    }
}
