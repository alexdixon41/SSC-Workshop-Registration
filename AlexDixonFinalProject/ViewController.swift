//
//  ViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 4/16/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {

    var authUI: FUIAuth?                                //only set internally but get externally
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let auth: Auth? = Auth.auth()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        auth?.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "toMainTabView", sender: self)
            }
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let authViewController = authUI?.authViewController();
        present(authViewController!, animated: true, completion: nil)
    }
    
    func logoutAction() {
        let auth: Auth? = Auth.auth()
        do {
            try auth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if user != nil {
            print("success!")
            performSegue(withIdentifier: "toMainTabView", sender: self)
        }
        else {
            print("not signed in")
        }
    }

}

