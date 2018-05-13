//
//  HomeViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        Alamofire.request(url).responseImage { response in
            
            if let image = response.result.value {
                self.image = image
            }
        }
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var homeTableView: UITableView!
    var posts:[Post] = [Post]()
    var category:Category? = nil
//    var activityIndicator = UIActivityIndicatorView()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @objc func likeBtnAction(_ sender: UIButton, cell:HomePageTableViewCell) {
        if ViewController.isGuest {
            let alert = UIAlertController(title: self.title, message: "يجب عليك تسجيل الدخول لاستخدام هذه الخصوصية", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "goSignInPage", sender: self)                
            }))
            alert.addAction(UIAlertAction(title: "لا أريد", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableItem", for: indexPath) as! HomePageTableViewCell
        cell.itemProfileSub = posts[indexPath.row].itemKey
        cell.titleLabel.text = posts[indexPath.row].title
        cell.companyLabel.text = posts[indexPath.row].typePost
        cell.locationLabel.text = posts[indexPath.row].adresse
        cell.likeBtn.setTitle(posts[indexPath.row].getLikesCount() == 0 ? "" : String(posts[indexPath.row].getLikesCount()), for: .normal)
        if(ViewController.isGuest) {
            cell.likeBtn.addTarget(self, action: #selector(self.likeBtnAction(_: cell:)), for: .touchUpInside)
        }
        if(posts[indexPath.row].isLiked()) {
            cell.likeBtn.setImage(UIImage(named: "heart-outline-filled-25"), for: .normal)
        } else {
            cell.likeBtn.setImage(UIImage(named: "heart-outline-25"), for: .normal)
        }
        if(posts[indexPath.row].getOnePhoto() != nil) {
            cell.homeImageView.downloadedFrom(link: (posts[indexPath.row].getOnePhoto()?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil))!)
        }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "الصفَحة الرئيسيّة"
        let appServices = AppServices()
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = .gray
//        self.view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
        if ViewController.isGuest {
            
        }
        if category != nil {
            let defaults = UserDefaults.standard
            
            // Receive
            if let id_country = defaults.string(forKey: "id_country")
            {
                appServices.GetAllPostsByIdCategoryAndIdCountryAsync(idCategory: category?.idCategory, idCountry:id_country) {(posts) in
                self.posts = (posts)
                self.homeTableView.reloadData()
    //            self.activityIndicator.stopAnimating()
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPostDetails" {
            if let destination = segue.destination as? PostViewController {
                let cell = sender as! UITableViewCell
                let indexPath = homeTableView.indexPath(for: cell)
                let selectedData = posts[(indexPath?.row)!]
                destination.post = selectedData
            }
        }
        
    }
 

}
