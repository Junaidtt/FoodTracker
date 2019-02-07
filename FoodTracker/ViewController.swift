//
//  ViewController.swift
//  FoodTracker
//
//  Created by IBookHoliday5 on 2/7/19.
//  Copyright © 2019 IBookHoliday. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    //Mark:Properties
    @IBOutlet weak var naemTextField: UITextField!
    @IBOutlet weak var mealnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        naemTextField.delegate = self
        
        print("viewDidLoad")
    }
    
    //MARK: Actions
    @IBAction func setDefaultTextLabel(_ sender: Any) {
        
        mealnameLabel.text = "Default Text"
        
    }
    
    // Mark: Protocols
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        naemTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        mealnameLabel.text = textField.text
    }
    
    
    

}

