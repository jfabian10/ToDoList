//
//  ToBeDoneTableViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 12/1/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class ToBeDoneTableViewController: UITableViewController {
    
    
    @IBOutlet var tasksTableView: UITableView!
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var taskNames = [String]()
    var dataToPass = [String]()
    var taskTitlePassed : String = ""
    var taskNamesShort = [String]()
    var counter : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Be Done List"
        taskNames = applicationDelegate.dict_listData.allKeys as! [String]
        var updatedTaskNames = [String]()
        let countMax = taskNames.count
        var counter = 0
        taskNames.sort { $0 < $1 }
        while counter < countMax {
            let taskName = taskNames[counter]
            let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
            let taskArray = taskData as! [String]
            if taskArray[0] == "YES" {
                counter += 1
            }
            else {
                updatedTaskNames.append(taskName)
                counter += 1
            }
            counter += 1
        }
        
        taskNamesShort = updatedTaskNames
        tasksTableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.title = "To Be Done List"

        if counter != 1 {
        taskNames = applicationDelegate.dict_listData.allKeys as! [String]
        var updatedTaskNames = [String]()
        let countMax = taskNames.count
        var counter = 0
        taskNames.sort { $0 < $1 }
        while counter < countMax {
             let taskName = taskNames[counter]
            let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
            let taskArray = taskData as! [String]
            if taskArray[0] == "YES" {
                counter += 1
            }
            else {
                updatedTaskNames.append(taskName)
                counter += 1
            }
        }
        taskNamesShort = updatedTaskNames
        counter += 1
        tasksTableView.reloadData()

        
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let rowNumber = (indexPath as NSIndexPath).row
         let taskName = taskNamesShort[rowNumber]
         let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
        let taskArray = taskData as! [String]
        dataToPass = taskArray
        taskTitlePassed = taskName
        performSegue(withIdentifier: "toBeDoneShowTask", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskNamesShort.count
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBeDoneShowTask" {
            let taskReadOnlyViewController : TaskReadOnlyViewController = segue.destination as! TaskReadOnlyViewController
            taskReadOnlyViewController.dataPassed = dataToPass
            taskReadOnlyViewController.titlepassed = taskTitlePassed

        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ToBeDoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToBeDoneTableViewCell
        let rowNumber = (indexPath as NSIndexPath).row
        let taskName = taskNamesShort[rowNumber]
        let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
        let taskArray = taskData as! [String]
            let isDone = taskArray[0]
            let priorityLevel = taskArray[2]
            let dueDateAndTime = taskArray[3]
            //text color logic
            if priorityLevel == "Low" {
                cell.taskNameLabel.text = taskName
                cell.taskDateLabel.text = dueDateAndTime
            }
            else if priorityLevel == "Normal" {
                cell.taskNameLabel.text = taskName
                cell.taskNameLabel.textColor = UIColor.brown
                cell.taskDateLabel.text = dueDateAndTime
                cell.taskDateLabel.textColor = UIColor.brown
                
            }
            else if priorityLevel == "High" {
                cell.taskNameLabel.text = taskName
                cell.taskNameLabel.textColor = UIColor.red
                cell.taskDateLabel.text = dueDateAndTime
                cell.taskDateLabel.textColor = UIColor.red
            }
            if isDone == "YES" {
                cell.completedPicture.image = UIImage(named: "CheckedBox")
            }
            if isDone == "NO" {
                cell.completedPicture.image = UIImage(named: "CheckBox")
                
            }
        
            return cell

        
    }

   
}
