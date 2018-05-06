//
//  NewPostViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
                                UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let postTypes = ["محل", "شركة", "منزلي",]
    var postType:String? = ""
    var photos:[UIImage] = []
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

    @IBAction func photosBtnAction(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        showDetailViewController(imgPicker, sender: Any?.self)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            photos.append(originalImage as! UIImage)
        }
        dismiss(animated: true, completion: nil)
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
            for p in photos {
                if let uploadedData = UIImagePNGRepresentation(p) {
                    appServices.uploadFileToStorage(sub: profile_sub, uploadData: uploadedData)
                }
            }
            
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
