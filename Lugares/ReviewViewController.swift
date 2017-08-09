//
//  ReviewViewController.swift
//  Mis Recetas
//
//  Created by Felipe Hernandez on 09-07-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    

    @IBOutlet var bacgroundImageView: UIImageView!
    
    //se crea una referencia a la stack view para luego escalarla
    @IBOutlet var ratingStackView: UIStackView!
    
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    
    var ratingSelected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // difuminar imagen de fondo
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        bacgroundImageView.addSubview(blurEffectView)
        
        //escalar stackview
        /*self.ratingStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.ratingStackView.transform = CGAffineTransform(translationX: 0.0, y: 500.0)*/
        
        //concatenar dos transformaciones
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform(translationX: 0.0, y: 500.0)
        
        //ratingStackView.transform = scale.concatenating(translation)
        
        self.firstButton.transform = scale.concatenating(translation)
        self.secondButton.transform = scale.concatenating(translation)
        self.thirdButton.transform = scale.concatenating(translation)
        
        
    }
    
    //se sobrescribe el metodo viewDidAppear para el escalado
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }, completion: nil)*/
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
        case 2:
            ratingSelected = "good"
        case 3:
            ratingSelected = "great"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }

   

}
