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
    
    let dateIndex = 0                               // date Strings are stored in first column of dates
    
    // shape of events: [
    //                      [[eventTitle], [eventDescription], [eventTimes]]
    //                  ]
    var events: [[[String]]] = []                   // initialize array of events with all information for each event
    
    var selectedEventInfo: [[String]] = []          // initialize array to store info for the event selected to use in the detail scene
    
    @IBOutlet weak var upcomingTableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count                         // return how many events are upcoming
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsListCell")
        cell!.textLabel!.text = events[indexPath.row][0][0]                         // put the event title in the tableview cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEventInfo = events[indexPath.row]
        
        performSegue(withIdentifier: "upcomingToDetails", sender: self)             // show event details when event selected
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get all events from database and save to events array
        ref = Database.database().reference()
        
        ref.child("info").child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            let eventDict = snapshot.value as! NSDictionary
            self.events.removeAll()                         // clear the events array before reading from db
            
            for event in eventDict {
                let eventInfo = event.value as! NSDictionary
                var times: [String] = []
                for time in eventInfo.value(forKey: "times") as! NSDictionary {
                    times.append(time.value as! String)
                }
                
                self.events.append([[eventInfo.value(forKey: "title") as! String], [eventInfo.value(forKey: "description") as! String], times])
            }
            self.upcomingTableview.reloadData()
        })
        
    }

    // Send selected event info to EventDetailsViewController before showing it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        (segue.destination as! EventDetailsViewController).eventInfo = selectedEventInfo                // copy info for the selected event to the event details vc
    }

}
