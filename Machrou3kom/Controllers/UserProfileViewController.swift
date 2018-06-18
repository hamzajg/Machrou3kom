//
//  UserProfileViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var updatePostBtn: UIButton!
    @IBOutlet weak var changeCountryBtn: UIButton!
    @IBOutlet weak var signOutBtn: UIButton!
    static var isChangingCountry:Bool = false
    @IBAction func changeCountryBtnAction(_ sender: UIButton) {
        UserProfileViewController.isChangingCountry = true
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goCountryPage", sender: self)
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
        logoView.frame = CGRect(x: bannerX + 20, y: bannerY, width: bannerWidth, height: bannerHeight)
        logoView.contentMode = .scaleAspectFit
        logoView.center = navView.center
        // Setting the image frame so that it's immediately before the text:
        CountryViewController.countryImageView.frame = CGRect(x: 250, y: 10, width: 40, height: 30)
        CountryViewController.countryImageView.contentMode = .scaleToFill
//        CountryViewController.countryImageView.layer.cornerRadius = CountryViewController.countryImageView.frame.size.width / 2 - 3
        CountryViewController.countryImageView.layer.borderWidth = 2
        CountryViewController.countryImageView.layer.borderColor = UIColor.white.cgColor
        CountryViewController.countryImageView.clipsToBounds = true
        // Add both the label and image view to the navView
        navView.addSubview(logoView)
        navView.addSubview(CountryViewController.countryImageView)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarManyImageView()
        if ViewController.isGuest {
            self.userNameLabel.isHidden = true
            self.userProfileImageView.isHidden = true
            self.changeCountryBtn.isHidden = true
            self.updatePostBtn.isHidden = true
            self.signOutBtn.isHidden = true
            let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "SingIn") as! ViewController
            self.navigationController?.setViewControllers([viewController], animated: true)
        } else if SessionManager.profile != nil {
            self.userNameLabel.isHidden = false
            self.userProfileImageView.isHidden = false
            self.changeCountryBtn.isHidden = false
            self.updatePostBtn.isHidden = false
            self.signOutBtn.isHidden = false
            self.userNameLabel.text = SessionManager.profile.name
            if SessionManager.profile != nil {
                self.userProfileImageView.downloadedFrom(url: SessionManager.profile.picture!)
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutBtnAction(_ sender: UIButton) {
        ViewController.isGuest = false
        SessionManager.logOut()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
