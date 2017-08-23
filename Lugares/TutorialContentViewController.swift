//
//  TutorialContentViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/18/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var tutorialStep : TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.tutorialStep.heading
        self.contentImageView.image = self.tutorialStep.image
        self.contentLabel.text = self.tutorialStep.content
        
        self.pageControl.currentPage = self.tutorialStep.index
        
        switch self.tutorialStep.index {
        case 0...1:
            self.nextButton.setTitle("Siguiente", for: .normal)
            
        case 2:
            self.nextButton.setTitle("Empezar", for: .normal)
        default:
            break
        }
        
    }
    
    
    @IBAction func nextPress(_ sender: UIButton) {
        
        switch self.tutorialStep.index {
            
        case 0...1:
            let pageViewController = parent as! TutorialViewController
            pageViewController.forward(toIndex: self.tutorialStep.index)
            
        case 2:
            
            //si el tutorial se vio, se setea true la clave haViewedTutorial
            //que es un diccionario para guardar configuraciones
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedTutorial")
            
            self.dismiss(animated: true, completion: nil)
            
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
