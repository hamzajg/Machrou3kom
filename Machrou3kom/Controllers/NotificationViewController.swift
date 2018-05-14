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
    
    func addNavBarImageView() {
        
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "finalmashroukom-horiz-1")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImageView()
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
