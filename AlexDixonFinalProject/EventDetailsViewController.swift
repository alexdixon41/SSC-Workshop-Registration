//
//  EventDetailsViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 4/23/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit
import CoreData

class EventDetailsViewController: UIViewController {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var eventInfo: [[String]] = []
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet var timeLabels: [UILabel]!
    @IBOutlet var registerButtons: [UIButton]!
    
    @IBAction func registerEvent(_ sender: UIButton) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: managedObjectContext)            // core data context
        
        // check for time conflict
        if checkTimeConflict(eventInfo[2][registerButtons.firstIndex(of: sender)!]) {
            let ac = UIAlertController(title: "Time Conflict", message: "You have already registered for an event at the same time", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            present(ac, animated: true, completion: nil)                    // show alert that event was not registered because of time conflict with another registered event
            return
        }
        
        // create event entity for event to register
        let event = Event(entity: entityDescription!, insertInto: managedObjectContext)
        event.name = eventInfo[0][0]
        event.eventDescription = eventInfo[1][0]
        event.time = eventInfo[2][registerButtons.firstIndex(of: sender)!]
        
        do {
            // save changes in persistent storage
            try managedObjectContext.save()
            
            // alert user that event was registered
            let ac = UIAlertController(title: "Registered", message: "The event was registered", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        catch let error {
            // show alert that event registration encountered an error
            let ac = UIAlertController(title: "Registration Failed", message: "The event was not registered: \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func returnToPrevious(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // display info for selected event
        eventTitle.text = eventInfo[0][0]
        eventDescription.text = eventInfo[1][0]
        
        // show as many time labels and buttons as needed for the number of times available for the selected event (max 5)
        for i in 0 ..< eventInfo[2].count {
            timeLabels[i].isHidden = false
            timeLabels[i].text = eventInfo[2][i]
            registerButtons[i].isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // check if another event occurs at the same time
    func checkTimeConflict(_ eventTime: String) -> Bool {
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        
        fetchRequest.predicate = NSPredicate(format: "time = %@", eventTime)            // get events from core data with same time
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)                  // attempt to fetch from core data
            if results.count == 0 {
                return false                // no conflicting events so return false
            }
            return true                     // registered events found at the same time
        }
        catch let error {
            let ac = UIAlertController(title: "Registration Failed", message: "The event was not registered: \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            present(ac, animated: true, completion: nil)
            return false
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
