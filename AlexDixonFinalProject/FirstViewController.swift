//
//  FirstViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 4/23/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events: NSDictionary = [:]
    var days: NSDictionary = [:]
    
    let exampleDays = ["April 23, 2019", "April 24, 2019", "April 30, 2019"]
    let exampleNames = ["Donut Burn Out", "Preparing for Finals"]
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exampleDays[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsListCell")
        cell!.textLabel!.text = exampleNames[indexPath.row]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "upcomingToDetails", sender: self)
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get event value
            self.events = (snapshot.value as? NSDictionary)!
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("days").observeSingleEvent(of: .value, with: { (snapshot) in
            // get days value
            self.days = (snapshot.value as? NSDictionary)!
        }) { (error) in
            print(error.localizedDescription)
        }
        
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
