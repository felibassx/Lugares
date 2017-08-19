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
    
    var tutorialStep : TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.tutorialStep.heading
        self.contentImageView.image = self.tutorialStep.image
        self.contentLabel.text = self.tutorialStep.content
        
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
