//
//  ViewController.swift
//  Promise Child Cards
//
//  Created by Marcus Houpt on 4/10/18.
//  Copyright © 2018 Promise Child. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "createCards" {
            let createVC:CreateCardVC = segue.destination as! CreateCardVC
            present(createVC, animated: false, completion: nil)
        }
        else if segue.identifier == "viewCards" {
            let viewVC:ViewCardsVC = segue.destination as! ViewCardsVC
            present(viewVC, animated: false, completion: nil)
        }
        else if segue.identifier == "tutorial" {
            let tutorialVC:TutorialVC = segue.destination as! TutorialVC
            present(tutorialVC, animated: false, completion: nil)
        }
    }

    @IBAction func createCardsButton(_ sender: Any) {
        performSegue(withIdentifier: "createCards", sender: self)
    }
    
    @IBAction func viewCardsButton(_ sender: Any) {
        performSegue(withIdentifier: "viewCards", sender: self)
    }
    
    @IBAction func tutorialButton(_ sender: Any) {
        performSegue(withIdentifier: "tutorial", sender: self)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
    }
    
    
}

