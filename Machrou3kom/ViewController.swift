//
//  ViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit
import Auth0

class ViewController: UIViewController {
    
    static var isGuest:Bool = false
    @IBOutlet weak var guestBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ViewController.isGuest) {
            guestBtn.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func guestBtnAction(_ sender: UIButton) {
        ViewController.isGuest = true
        //self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "goCountryPage", sender: self)
    }
    @IBAction func signInBtnAction(_ sender: UIButton) {
        var token:String = ""
        Auth0
            .webAuth()
            .connection("instagram")
            .audience("https://machrou3kom.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    //print("Credentials: \(credentials)")
                    token = credentials.accessToken!
                    Auth0
                        .authentication()
                        .userInfo(withAccessToken: token)
                        .start { result in
                            switch result {
                            case .success(let profile):
                                //print("User Profile: \(profile.sub)")
                                let defaults = UserDefaults.standard
                                
                                // Store
                                defaults.set(profile.sub, forKey: "profile_sub")
                                let appServices = AppServices()
                                appServices.AddNewUser(user: User(idUser: profile.sub, full_name: profile.sub, profile_picture: ""))
                                
                            case .failure(let error):
                                print("Failed with \(error)")
                            }
                    }
                    self.dismiss(animated: true, completion: nil)
                    if ViewController.isGuest {
                        self.performSegue(withIdentifier: "goCountryPage", sender: self)
                    } else {
                        let defaults = UserDefaults.standard
                        if (defaults.string(forKey: "id_country") != nil)
                        {
                            self.performSegue(withIdentifier: "ShowCategoryPage", sender: self)
                        } else {
                            self.performSegue(withIdentifier: "goCountryPage", sender: self)
                        }
                    }
                }
        }
        ViewController.isGuest = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

