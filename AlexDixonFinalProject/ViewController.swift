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

    var authUI: FUIAuth?                        // default UI flow to sign in to Firebase - only use email address and password
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let auth: Auth? = Auth.auth()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        // check if user is signed in
        auth?.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "toMainTabView", sender: self)        // go to tab bar controller if user logged in
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // log in the user
    @IBAction func loginAction(_ sender: UIButton) {
        let authViewController = authUI?.authViewController();
        present(authViewController!, animated: true, completion: nil)
    }
    
    // log out
    func logoutAction() {
        let auth: Auth? = Auth.auth()
        do {
            try auth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    // go to main tab bar controller on sign in
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if user != nil {
            performSegue(withIdentifier: "toMainTabView", sender: self)
        }
        else {
            print("not signed in")
        }
    }

}

