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
        let defaults = UserDefaults.standard
        if let id_country = defaults.string(forKey: "id_country") {
            
            let appServices = AppServices()
            appServices.GetOneCountryByIdCountryAsync(idCountry: id_country) {(country) in
                self.country = (country)
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
                                    //self.view.addSubview(adsBtn)
                                    self.categoryTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 105))
                                    self.categoryTableView.tableHeaderView?.addSubview(adsBtn)
    //                                if self.countryFlagBarBtn != nil {
    //                                    self.countryFlagBarBtn.image = image
    //
    //                                }
                            
                                }
                            }.resume()
                        }
                    }
                }
            }
        }
        if(!isSubCategory) {
            let appServices = AppServices()
            appServices.GetAllCategoriesAsync() {(categories) in
                self.categories = (categories)
                self.categoryTableView.reloadData()
            }
        } else {
            self.categoryTableView.reloadData()
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
                destination.title = categories[(indexPath?.row)!].name
                destination.isSubCategory = true
                destination.categories = selectedData
            }
        } else if segue.identifier == "goHomePage" {
            if let destination = segue.destination as? HomeViewController {
                let cell = sender as! UITableViewCell
                let indexPath = categoryTableView.indexPath(for: cell)
                let selectedData = categories[(indexPath?.row)!]
                destination.category = selectedData
                let defaults = UserDefaults.standard
                
                // Store
                defaults.set(selectedData.idCategory, forKey: "id_category")
            }
        }
    }
    

}
