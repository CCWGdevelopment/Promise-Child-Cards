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
    
    @IBAction func saveButton(_ sender: Any) {
        
        if numberTextField.text != "" {
          
            let pcNum = numberTextField.text!
            let age = ageTextField.text!
            let country = countryTextField.text!
            let name = nameTextField.text!
            let description = descripTextView.text!
            let fileName = pcNum
            
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")

            print("File Path: \(fileURL.path)")
            
            let writeString = "\(name)\t\(age)\t\(country)\t\(description)"
            
            do{
                try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Faile to write to URL")
                print(error)
            }
            
            saveImage(imageName: "\(pcNum)\(name).png")
        }
        
        let imageData = UIImagePNGRepresentation(imageView.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        print("Image Data: \(String(describing: imageData))")
        
        let alert = UIAlertController(title: "Saved", message: "Your file was saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func testButton(_ sender: Any) {
       
        let pcNum = numberTextField.text!
        let fileName = pcNum
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Faile to write to URL")
            print(error)
        }
        
        descripTextView.text = readString
    }
    
    @IBAction func takePhotoButton(_ sender: Any) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        //check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func saveImage(imageName: String){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = imageView.image!
        //get the PNG data for this image
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        print("Image Path: \(imagePath)")
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
            print("Image: \(mediaType)")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
