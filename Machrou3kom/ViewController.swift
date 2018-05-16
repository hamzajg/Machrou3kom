//
//  ViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit
import Auth0
import Firebase

class ViewController: UIViewController {
    
    static var isGuest:Bool = false
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarManyImageView()
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
                        if self.navigationController == nil {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    Auth0
                        .authentication()
                        .userInfo(withAccessToken: token)
                        .start { result in
                            switch result {
                            case .success(let profile):
                                SessionManager.profile = profile
                                ViewController.isGuest = false
                                Messaging.messaging().subscribe(toTopic: profile.sub.replacingOccurrences(of: "|", with: "", options: .literal, range: nil))
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
    
    
    func addNavBarManyImageView() {
        
        // Only execute the code if there's a navigation controller
        if self.navigationController == nil {
            return
        }
        let navController = navigationController!
        
        // Create a navView to add to the navigation bar
        let navView = UIView()
        
        let logo = #imageLiteral(resourceName: "finalmashroukom-horiz-1")
        let logoView = UIImageView(image: logo)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height + 30
        
        let bannerX = bannerWidth / 2 - logo.size.width / 2
        let bannerY = bannerHeight / 2 - logo.size.height / 2
        navView.frame = CGRect(x: -10, y: -10, width: bannerWidth, height: bannerHeight)
        logoView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        logoView.contentMode = .scaleAspectFit
        logoView.center = navView.center
        // Add both the label and image view to the navView
        navView.addSubview(logoView)
        if CountryViewController.countryImageView != nil {
            
            CountryViewController.countryImageView.frame = CGRect(x: 250, y: 10, width: 40, height: 30)
            CountryViewController.countryImageView.contentMode = .scaleToFill
//            CountryViewController.countryImageView.layer.cornerRadius = CountryViewController.countryImageView.frame.size.width / 2 - 3
            CountryViewController.countryImageView.layer.borderWidth = 2
            CountryViewController.countryImageView.layer.borderColor = UIColor.white.cgColor
            CountryViewController.countryImageView.clipsToBounds = true
            
            navView.addSubview(CountryViewController.countryImageView)
        }
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

