//
//  NewPostViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let postTypes = ["محل", "شركة", "منزلي",]
    var postType:String? = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return postTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return postTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        postType = postTypes[row]
    }

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "منشور جديد"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addBtnAction(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        // Receive
        if let profile_sub = defaults.string(forKey: "profile_sub")
        {
            let appServices = AppServices()
            appServices.AddNewPoat(sub: profile_sub, post: Post(itemRef: nil, itemKey: "", adresse: locationTextField.text, catagory_country: "-LBDACWVCIVuWWoI1y9q_-L6fyXUG0z_vXuLJk2hi", description: descTextView.text,
                                                                idCategory: "-LBDACWVCIVuWWoI1y9q", idCountry: "-L6fyXUG0z_vXuLJk2hi", numTel: phoneNumberTextField.text, title: titleTextField.text, post_owner: profile_sub, typePost: postType))
            
        }
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
