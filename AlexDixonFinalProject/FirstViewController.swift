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
    
    let dateIndex = 0           // date Strings are stored in first column of dates
    let eventIndex  = 1         // event IDs are stored in second column of dates
    var dates: [[[String]]] = [
        [
            [""], [""]]]            // initialize shape of dates array for table view initialization
    
    @IBOutlet weak var upcomingTableview: UITableView!
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section][dateIndex][dateIndex]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates[section][eventIndex].count             // return how many events for section date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsListCell")
        cell!.textLabel!.text = dates[indexPath.section][eventIndex][indexPath.row]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "upcomingToDetails", sender: self)
    }
    
    var ref: DatabaseReference!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref = Database.database().reference()
        
        ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("days").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            var dates: [[[String]]] = []
            
            for day in value! {
                let dayInfo = day.value as? NSDictionary
                let dayEvents: [String] = (dayInfo!.value(forKey: "eventIDs") as! NSDictionary).allValues as! [String]
                
                let date: [[String]] = [[(dayInfo!.value(forKey: "date") as! String)], dayEvents]
                dates.append(date)
                
                // dates = [[[dateString], [eventsForDate]],
                //          [[dateString2], [eventsForDate2]]
                //         ]
            }

            self.dates = dates
            
            self.upcomingTableview.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
