//
//  AppServices.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AppServices {
    
    var ref:DatabaseReference?
    
    func GetAllPost() {
        ref = Database.database().reference()
        ref?.child("Posts").observe(.childAdded, with: {(snapshot) in
            let post = snapshot.value
            print(post)
        })
    }
    
}
