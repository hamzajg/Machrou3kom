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
        ref?.child("Posts").observeSingleEvent(of: .value, with: {(snapshot) in
            let data = snapshot.value
            print(data! as? [String])
//            do {
//                let json = try? JSONEncoder().encode(data! as? String)
//                print(json)
//                let post = try? JSONDecoder().decode(Post.self, from: json!)
//                print(post)
//            } catch let jsonErr {
//                print("GetAllPost Error serializing json: ", jsonErr)
//            }
        })
    }
    
}
