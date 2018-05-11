//
//  AppServices.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class AppServices {
    
    var ref:DatabaseReference?
    
    func GetAllPostsAsync(completed: @escaping ([Post]) -> ()){
        var posts = [Post]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: {(snapshot) in
                for p in snapshot.children {
                    let post = Post(snapshot: p as! DataSnapshot)
                    posts.append(post)
                }
                completed(posts)
            })
        }
    }
    func GetAllCountriesAsync(completed: @escaping ([Country]) -> ()){
        var countries = [Country]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Countries").observeSingleEvent(of: .value, with: {(snapshot) in
                for c in snapshot.children {
                    let country = Country(snapshot: c as! DataSnapshot)
                    if country.active {
                        countries.append(country)
                    }
                }
                completed(countries)
            })
        }
    }
    func GetOneCountryByIdCountryAsync(idCountry:String, completed: @escaping (Country?) -> ()){
        var country:Country?
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Countries").observeSingleEvent(of: .value, with: {(snapshot) in
                country = Country(snapshot: snapshot.childSnapshot(forPath: idCountry))
                completed(country)
            })
        }
    }
    func GetAllNotificationsByUserAsync(user_sub:String!,completed: @escaping ([Notification]) -> ()){
        var notifications = [Notification]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("notifications").observeSingleEvent(of: .value, with: {(snapshot) in
                for n in snapshot.children {
                    if (n as! DataSnapshot).childSnapshot(forPath: "userKey").value as? String == user_sub {
                        let notification = Notification(snapshot: n as! DataSnapshot)
                        notifications.append(notification)
                    }
                }
                completed(notifications)
            })
        }
    }
    func GetAllPostsByIdCategoryAndIdCountryAsync(idCategory:String!, idCountry:String!, completed: @escaping ([Post]) -> ()){
        var posts = [Post]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: {(snapshot) in
                for p in snapshot.children {
                    if (p as! DataSnapshot).childSnapshot(forPath: "idCategory").value as? String == idCategory &&
                        (p as! DataSnapshot).childSnapshot(forPath: "idCountry").value as? String == idCountry {
                        let post = Post(snapshot: p as! DataSnapshot)
                        posts.append(post)
                    }
                }
                posts = posts.sorted(by: {$0.getLikesCount() > $1.getLikesCount()})
                completed(posts)
            })
        }
    }
    
    func LikePost(sub1:String, sub2:String) {
        ref = Database.database().reference()
        self.ref?.child("Posts").child(sub1).child("like").updateChildValues([sub2: Date().description])
    }
    
    func AddNewPoat(sub:String, post:Post) {
        ref = Database.database().reference()
        self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(sub) {
                self.ref?.child("Posts").child(sub).setValue(post.toAnyObject())
            }
        })
    }
    func AddNewUser(user:User) {
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(user.idUser) {
                self.ref?.child("Users").child(user.idUser).setValue(user.toAnyObject())
            }
        })
    }
    func UpdateUser(user:User) {
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(user.idUser) {
                self.ref?.child("Users").child(user.idUser).setValue(user.toAnyObject())
            }
        })
    }
    func GetOneUser(sub:String, completed: @escaping (User?) -> ()){
        var user:User?
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(sub) {
                user = User(snapshot: snapshot.childSnapshot(forPath: sub))
                }
                completed(user)
        })
    }
    func GetOnePostByUserAsync(sub:String, completed: @escaping (Post?) -> ()){
        var post:Post?
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(sub) {
                    post = Post(snapshot: snapshot.childSnapshot(forPath: sub))
                }
                completed(post)
            })
        }
    }
    func AddNewNotification(sub1:String, sub2:String) {
        ref = Database.database().reference()
        self.ref?.child("notifications").childByAutoId().setValue(["body":"A user has liked your post", "title":"Your post was liked", "userKey":sub2])
    }
    func GetAllCategoriesAsync(completed: @escaping ([Category]) -> ()){
        var categories = [Category]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Categories").observeSingleEvent(of: .value, with: {(snapshot) in
                for c in snapshot.children {
                    let category = Category(snapshot: c as! DataSnapshot)
                    categories.append(category)
                }
                completed(categories)
            })
        }
    }
    
    func uploadFileToStorage(sub:String, uploadData:Data?) {
        print(String(Date().hashValue))
        let storageRef = Storage.storage().reference().child("images").child(String(Date().hashValue) + ".png")
        storageRef.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            if error != nil {
            print(error)
            return
            }
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(sub) {
                    self.ref?.child("Posts").child(sub).child("photos").childByAutoId().setValue(["url" : metadata?.downloadURL()?.absoluteString])
                }
            })
        })
    }
    
}
