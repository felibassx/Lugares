//
//  AddPlaceViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/9/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textViewName: UITextField!
    @IBOutlet var textViewType: UITextField!
    @IBOutlet var textViewDirection: UITextField!
    @IBOutlet var textViewTelephone: UITextField!
    @IBOutlet var textViewWebsite: UITextField!

    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!

    var rating : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //concatenar dos transformaciones
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform(translationX: 0.0, y: 500.0)
        
        //ratingStackView.transform = scale.concatenating(translation)
        
        self.firstButton.transform = scale.concatenating(translation)
        self.secondButton.transform = scale.concatenating(translation)
        self.thirdButton.transform = scale.concatenating(translation)
        
        self.textViewName.delegate = self
        self.textViewType.delegate = self
        self.textViewDirection.delegate = self
        self.textViewTelephone.delegate = self
        self.textViewWebsite.delegate = self


       
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
    }
    
    //action rating
    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            self.rating = "good"
        case 2:
            self.rating = "dislike"
        case 3:
            self.rating = "great"
        default:
            break
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //se sobrescribe el metodo viewDidAppear para el escalado
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            
            //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.firstButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }, completion: {(success) in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                
                //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.secondButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            }, completion: {(success) in
                
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                    
                    //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.thirdButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                }, completion: nil)
                
                
            })
            
            
        })
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //creo un objeto uipickerimage
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true)
                
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        //Autolayaout
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        bottomConstraint.isActive = true
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //ocultar teclado al presionar enter en el textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
