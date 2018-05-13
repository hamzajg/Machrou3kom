//
//  SessionManager.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-13.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import Auth0

class SessionManager {
    
    static var credentialsManager: CredentialsManager! = CredentialsManager(authentication: Auth0.authentication())
    init() {
        
    }
    static func getUserInfoProfile() -> (UserInfo?) {
        var userInfo:UserInfo!
        credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                // Handle error
                print("Error: \(error)")
                return
            }
            
            guard let accessToken = credentials.accessToken
                else {
                    // Handle Error
                    return
            }
            Auth0
                .authentication()
                .userInfo(withAccessToken: accessToken)
                .start { result in
                    switch(result) {
                    case .success(let profile):                        
                        let defaults = UserDefaults.standard
                        
                        // Store
                        defaults.set(profile.sub, forKey: "profile_sub")
                        let appServices = AppServices()
                        appServices.AddNewUser(user: User(idUser: profile.sub, full_name: profile.sub, profile_picture: ""))
                        userInfo = profile
                        // You've got the user's profile, good time to store it locally.
                    // e.g. self.profile = profile
                    case .failure(let error):
                        // Handle the error
                        print("Error: \(error)")
                    }
            }
        }
        return userInfo
    }
    static func logOut() {
        credentialsManager.clear()
    }
}