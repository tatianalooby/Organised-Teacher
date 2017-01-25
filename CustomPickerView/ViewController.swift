//
//  ViewController.swift
//  CustomPickerView
//
//  Created by Tatiana Looby on 23/01/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var teachingGroups = [TeachingGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // get the data from core data
        getData()
        
        // reload data in the tableview
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachingGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PrototypeCell
        
        let teachingGroup = teachingGroups[indexPath.row]
        
        cell.teachingGroupLabel.text = teachingGroup.name
        cell.roomLabel.text = teachingGroup.room
        
        return cell
    }
    
    // get data from core data
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            teachingGroups = try context.fetch(TeachingGroup.fetchRequest())
        } catch {
            print("fetching failed")
        }

    }
    
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let teachingGroup = teachingGroups[indexPath.row]
            context.delete(teachingGroup)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //fetch new updated data from core data
            getData()
            
        }
        //reload new updated data
        tableView.reloadData()
    }

}

