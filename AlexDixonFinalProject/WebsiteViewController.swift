//
//  WebsiteViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 5/2/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {

    @IBOutlet weak var websiteView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // load the webpage for the chellgren success series workshops
        let request = URLRequest(url: URL(string: "https://successcenter.eku.edu/chellgren-success-series")!)
        websiteView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
