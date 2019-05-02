//
//  AccountViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 4/23/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTableView.dequeueReusableCell(withIdentifier: "accountTableCell")
        cell!.textLabel!.text = "Log Out"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == indexPath.row && indexPath.section == 0 {
            performSegue(withIdentifier: "backToLogin", sender: self)               // return to login screen and log out
            (presentedViewController as! ViewController).logoutAction()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
