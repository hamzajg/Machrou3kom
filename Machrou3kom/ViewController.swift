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
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        SessionManager.logOut()
        if(ViewController.isGuest) {
            guestBtn.isHidden = true
            welcomeLabel.isHidden = true
            appNameLabel.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        viewDidLoad()
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
            .scope("openid profile")
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
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                    Auth0
                        .authentication()
                        .userInfo(withAccessToken: token)
                        .start { result in
                            switch result {
                            case .success(let profile):
                                SessionManager.profile = profile
                                ViewController.isGuest = false
                                let defaults = UserDefaults.standard
                                if (defaults.string(forKey: "id_country") != nil)
                                {
                                    DispatchQueue.main.async {
//                                        let viewController: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! Machrou3komViewController
//                                        self.navigationController?.pushViewController(viewController, animated: true)
                                        self.performSegue(withIdentifier: "ShowCategoryPage", sender: self)
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "goCountryPage", sender: self)
                                    }
                                }
                            case .failure(let error):
                                print("Failed with \(error)")
                            }
                            
                    }
                    //                    if ViewController.isGuest {
                    //                        self.performSegue(withIdentifier: "goCountryPage", sender: self)
                    //                    } else {
//
                    //                    }
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

