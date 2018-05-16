//
//  NotificationViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-06.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var notifications:[Notification] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    @IBOutlet weak var notificationTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableCellView", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = notifications[indexPath.row].title
        cell.detailTextLabel?.text = notifications[indexPath.row].body
        return cell
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
            let alert = UIAlertController(title: self.title, message: "يجب عليك تسجيل الدخول لاستخدام هذه الخاصية", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: {(action:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "لا أريد", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            let appServices = AppServices()

            let defaults = UserDefaults.standard
            
            // Receive
            if let profile_sub = defaults.string(forKey: "profile_sub")
            {
                appServices.GetAllNotificationsByUserAsync(user_sub: profile_sub) {(notifications) in
                    self.notifications = (notifications)
                    self.notificationTableView.reloadData()
                }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
