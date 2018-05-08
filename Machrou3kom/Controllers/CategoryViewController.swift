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
    var isSubCategory:Bool = false
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableItem", for: indexPath) as! CategoryTableViewCell
        cell.CategoryNameLabel.text = categories[indexPath.row].name
        if(categories[indexPath.row].photo != nil) {
            cell.CategoryImageView.downloadedFrom(link: (categories[indexPath.row].photo?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil))!)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            if let destination = ((segue.destination as! UITabBarController).viewControllers![0] as? UINavigationController)?.viewControllers.first as? HomeViewController {
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
