//
//  CountryViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-06.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    

    @IBOutlet weak var countryTableView: UITableView!
    var countries:[Country] = []
    override func viewDidLoad() {
        super.viewDidLoad()

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goCategoryPage" {
            if let destination = segue.destination as? CategoryViewController {
                let cell = sender as! UITableViewCell
                let indexPath = countryTableView.indexPath(for: cell)
                let selectedData = countries[(indexPath?.row)!]
                let defaults = UserDefaults.standard
                
                // Store
                defaults.set(selectedData.idCountry, forKey: "id_country")
                
            }
        }
    }
    

}
