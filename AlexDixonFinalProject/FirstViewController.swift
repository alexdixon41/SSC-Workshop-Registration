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
    
    var eventDict: NSDictionary = NSDictionary()
    
    let dateIndex = 0                           // date Strings are stored in first column of dates
    var dates: [[[String]]] = []                // initialize array of dates for table view initialization
    var events: [[String]] = []                 // initialize array of events to be set from database
    
    @IBOutlet weak var upcomingTableview: UITableView!
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section][dateIndex][dateIndex]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates[section][dates[0].count - 1].count             // return how many events for section date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsListCell")
        let event = eventDict.value(forKey: dates[indexPath.section][dates[0].count - 1][indexPath.row]) as! NSDictionary
        cell!.textLabel!.text = (event.value(forKey: "title") as! String)
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "upcomingToDetails", sender: self)
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.child("info").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            self.eventDict = value?["events"] as! NSDictionary
            let dateDict = value?["days"] as! NSDictionary
            
            var dates: [[[String]]] = []
            var eventTitles: [[String]] = []
            
            for day in dateDict {
                let dayInfo = day.value as? NSDictionary
                let dayEvents: [String] = (dayInfo!.value(forKey: "eventIDs") as! NSDictionary).allValues as! [String]
                
                /*for event in dayEvents {
                    //events.append((eventDict.value(forKey: event) as! NSDictionary).allValues as! [String])
                    
                    let title = (eventDict.value(forKey: event) as! NSDictionary).value(forKey: "title")
                    
                }*/
                
                print(eventTitles)
                
                let date: [[String]] = [[(dayInfo!.value(forKey: "date") as! String)], dayEvents]
                dates.append(date)
                
                // shape of dates array:
                // dates = [[[dateString], [eventsForDate]],
                //          [[dateString2], [eventsForDate2]]]
            }

            self.dates = dates
            
            self.upcomingTableview.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
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
