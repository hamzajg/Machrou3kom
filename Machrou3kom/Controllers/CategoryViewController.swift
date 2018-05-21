//
//  CategoryViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var categoryTableView: UITableView!
    let appServices = AppServices()
    let defaults = UserDefaults.standard
    var categories:[Category] = [Category]()
    var country:Country!
    var isSubCategory:Bool = false
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    @IBOutlet weak var countryFlagBarBtn: UIBarButtonItem!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableItem", for: indexPath) as! CategoryTableViewCell
        cell.CategoryNameLabel.text = categories[indexPath.row].name
        if(categories[indexPath.row].photo != nil) {
            cell.CategoryImageView.downloadedFrom(link: (categories[indexPath.row].photo?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil))!)
            cell.CategoryImageView.contentMode = .scaleToFill
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    @objc func openUrlLink(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: country.ads[self.country.ads.count - 1].link)!)
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
            CountryViewController.countryImageView.frame = CGRect(x: 250,  y: 10, width: 40, height: 30)
//            CountryViewController.countryImageView.layer.cornerRadius = (CountryViewController.countryImageView.frame.size.width / 2) - 3
            CountryViewController.countryImageView.contentMode = .scaleToFill
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
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarManyImageView()
        if(!isSubCategory) {
            loadCountryAd()
            appServices.GetAllCategoriesAsync() {(categories) in
                self.categories = (categories)
                self.categoryTableView.reloadData()
            }
        } else {
            if self.categories.count == 0 {
             
                let alert = UIAlertController(title: self.title, message: "هذه الصفحة لا تحتوي على أي بيانات", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
            self.categoryTableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loadCountryAd() {
        
        if let id_country = defaults.string(forKey: "id_country") {
            appServices.GetOneCountryByIdCountryAsync(idCountry: id_country) {(country) in
                self.country = (country)
                if CountryViewController.countryImageView == nil {
                    
                    // Create the image view
                    CountryViewController.countryImageView = UIImageView()
                    //image.image = UIImage(named: "call")
                    CountryViewController.countryImageView.downloadedFrom(link: (country?.photo)!)
                    self.addNavBarManyImageView()
                }
                if self.country?.ads != nil {
                    if self.country.ads.count > 0 {
                        if let url = URL(string: (self.country.ads[self.country.ads.count - 1].img)) {
                            URLSession.shared.dataTask(with: url) { data, response, error in
                                guard
                                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                                    let data = data, error == nil,
                                    let image = UIImage(data: data)
                                    else { return }
                                DispatchQueue.main.async() {
                                    let adsBtn = UIButton()
                                    adsBtn.setImage(image, for: .normal)
                                    adsBtn.frame = CGRect(x: 5, y: 3, width: self.view.frame.size.width - 15, height: 100)
                                    adsBtn.addTarget(self, action: #selector(self.openUrlLink(_:)), for: .touchUpInside)
                                    
                                    self.categoryTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 105))
                                    self.categoryTableView.tableHeaderView?.addSubview(adsBtn)
                                    
                                }
                            }.resume()
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goSubCategory" {
            if let destination = segue.destination as? CategoryViewController {
                let cell = sender as! UITableViewCell
                let indexPath = categoryTableView.indexPath(for: cell)
                let selectedData = categories[(indexPath?.row)!].subCategories
                destination.isSubCategory = true
                destination.categories = selectedData
                // Create a navView to add to the navigation bar
            }
        } else if segue.identifier == "goHomePage" {
            if let destination = segue.destination as? HomeViewController {
                let cell = sender as! UITableViewCell
                let indexPath = categoryTableView.indexPath(for: cell)
                let selectedData = categories[(indexPath?.row)!]
                destination.category = selectedData
                
                // Store
                defaults.set(selectedData.idCategory, forKey: "id_category")
            }
        }
    }
    

}

