//
//  CountryViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-06.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { 
    static var countryImageView:UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryTableViewCell", for: indexPath) as! CountryTableViewCell
        //cell.countryLabel.text = countries[indexPath.row].name
        if(countries[indexPath.row].photo != nil) {
            cell.countryImageView.downloadedFrom(link: (countries[indexPath.row].photo?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil))!)
            cell.countryImageView?.layer.cornerRadius = (cell.countryImageView?.frame.size.width)! / 3
            cell.countryImageView?.clipsToBounds = true
            cell.countryImageView?.layer.masksToBounds = true
            cell.countryImageView?.layer.borderWidth = 3
            cell.countryImageView?.layer.borderColor = UIColor.white.cgColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        let selectedData = countries[indexPath.row]

        // Create the image view
        CountryViewController.countryImageView = UIImageView()
        //image.image = UIImage(named: "call")
        CountryViewController.countryImageView.downloadedFrom(link: countries[indexPath.row].photo)
        
        // Store
        defaults.set(selectedData.idCountry, forKey: "id_country")
        if !UserProfileViewController.isChangingCountry {
            let viewController: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! Machrou3komViewController
            
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(viewController, animated: true)
            let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack))
            (viewController.childViewControllers.first! as? UINavigationController)!.childViewControllers.first?.navigationController?.navigationItem.leftBarButtonItem = backButton
        } else {
            DispatchQueue.main.async {
                UserProfileViewController.isChangingCountry = false
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    

    func addNavBarImageView() {
        
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
        navView.frame = CGRect(x: 0, y: -10, width: bannerWidth, height: bannerHeight)
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
    @IBOutlet weak var countryTableView: UITableView!
    var countries:[Country] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImageView()
        let appServices = AppServices()
        appServices.GetAllCountriesAsync() {(countries) in
            self.countries = (countries)
            self.countryTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}

}
