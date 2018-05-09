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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ViewController.isGuest {
            dismiss(animated: true, completion: nil)
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
