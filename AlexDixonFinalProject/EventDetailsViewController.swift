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
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet var timeLabels: [UILabel]!
    @IBOutlet var registerButtons: [UIButton]!
    
    @IBAction func registerEvent(_ sender: UIButton) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: managedObjectContext)
        
        let event = Event(entity: entityDescription!, insertInto: managedObjectContext)
        
        //event.name = eventInfo[0][0]
        //event.eventDescription = eventInfo[1][0]
    }
    
    
    var eventInfo: [[String]] = []
    
    @IBAction func returnToPrevious(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventTitle.text = eventInfo[0][0]
        eventDescription.text = eventInfo[1][0]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
