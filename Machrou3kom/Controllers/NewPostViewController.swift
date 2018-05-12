//
//  NewPostViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
                                UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "منشور جديد"
        if !ViewController.isGuest {
            let appServices = AppServices()
            let defaults = UserDefaults.standard
            
            // Receive
            if let profile_sub = defaults.string(forKey: "profile_sub")
            {
                appServices.GetOnePostByUserAsync(sub: profile_sub) {(post) in
                    let post = (post)
                    if post != nil {
                        self.titleTextField.text = post?.title
                        self.phoneNumberTextField.text = "\(post?.numTel as! Int)"
                        self.locationTextField.text = post?.adresse
                        self.descTextView.text = post?.description
                    }
                }
            }
        }
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 220), animated: true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    @IBAction func addBtnAction(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        // Receive
        if let profile_sub = defaults.string(forKey: "profile_sub")
        {
            if let idCountry = defaults.string(forKey: "id_country") {
                if let idCategory = defaults.string(forKey: "id_country") {
                    do {
                        let appServices = AppServices()
                        try appServices.AddNewPoat(sub: profile_sub, post: Post(itemRef: nil, itemKey: "", adresse: locationTextField.text, catagory_country: idCategory + "_" + idCountry, description: descTextView.text, idCategory: idCategory, idCountry: idCountry, numTel: Int(phoneNumberTextField.text!)!, title: titleTextField.text, post_owner: profile_sub, typePost: postType))
                        for p in photos {
                            if let uploadedData = UIImagePNGRepresentation(p) {
                                appServices.uploadFileToStorage(sub: profile_sub, uploadData: uploadedData)
                            }
                        }
                        let alert = UIAlertController(title: self.title, message: ".تم حفظ الإعلان بنجاح", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    } catch {
                        let alert = UIAlertController(title: self.title, message: ".هناك مشكلة في حفظ الإعلان", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    }
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
