//
//  WebViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 24-08-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    var urlName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlName){
            let request = URLRequest(url: url)
            self.webView.loadRequest(request)
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
