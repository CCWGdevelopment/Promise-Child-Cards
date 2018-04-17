//
//  CreateCardVC.swift
//  Promise Child Cards
//
//  Created by Marcus Houpt on 4/10/18.
//  Copyright © 2018 Promise Child. All rights reserved.
//

import UIKit
import MobileCoreServices

class CreateCardVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var descripTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func takePhotoButton(_ sender: Any) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)


    }
    

}

extension CreateCardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == (kUTTypeImage as String) {
            self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        } else {
//            self.dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
