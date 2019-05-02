//
//  RegisteredViewController.swift
//  AlexDixonFinalProject
//
//  Created by Dixon, Alex J. on 4/23/19.
//  Copyright © 2019 Dixon, Alex J. All rights reserved.
//

import UIKit
import CoreData

class RegisteredViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext      // core data context
    
    var registeredEvents: [[String]] = []               // initialize array to store all registered events from core data
    
    @IBOutlet weak var registeredTableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registeredEvents.count                   // set enough rows to display all registered events
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registeredEventCell")
        cell!.textLabel!.text = registeredEvents[indexPath.row][0]              // put title of event in tableview cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let ac = UIAlertController(title: "\(registeredEvents[indexPath.row][0])", message: "\(registeredEvents[indexPath.row][2])\n\(registeredEvents[indexPath.row][1])", preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(ac, animated: true, completion: nil)                            // show an alert with the information for the event when its accessory button pressed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // get registered events from core data and save to registeredEvents array
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            self.registeredEvents.removeAll()                   // empty array before adding events from core data
            for i in results {
                self.registeredEvents.append([i.name!, i.eventDescription!, i.time!])
            }
            registeredTableView.reloadData()                    // reload the tableview to show the events from core data
        }
        catch let error {
            print(error.localizedDescription)
        }
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
