//
//  ViewController.swift
//  FoodTracker
//
//  Created by IBookHoliday5 on 2/7/19.
//  Copyright © 2019 IBookHoliday. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //Mark:Properties
    @IBOutlet weak var naemTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        naemTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    // Mark: Protocols
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        naemTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
      print("Tap guesture cliked")
        // hide the keyboard
        naemTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        
        let imagePickerController = UIImagePickerController()
        
        //only allows photos to be picked
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = naemTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = naemTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

