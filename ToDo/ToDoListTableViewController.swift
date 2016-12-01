//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 11/30/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, AddTaskViewControllerProtocol, ChangeTaskViewControllerProtocol {
    
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var tasksTableView: UITableView!
    var taskNames = [String]()
    var dataToPassed = [String]()
    var taskTitlePassed : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNames = applicationDelegate.dict_listData.allKeys as! [String]
        taskNames.sort { $0 < $1 }
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ToDoListTableViewController.addTask(_:)))
        self.navigationItem.rightBarButtonItem = addButton
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
         let tasks: AnyObject? = applicationDelegate.dict_listData as AnyObject
        return (tasks?.allKeys.count)!
    }
    
    func changeTaskViewController(_ controller: ChangeTaskViewController, didFinishWithSave save: Bool) {
        if save {
            let titleChanged : String = controller.titleTextField.text!
            let descriptionChanged : String = controller.descriptionTextView.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            let dateAndTime = controller.dueDate.date
            let timeDateAdded = dateFormatter.string(from: dateAndTime)
            let priorityChanged = controller.priorityType
            let completedChanged = controller.completedType
            
            if titleChanged != "" && descriptionChanged != "" && timeDateAdded != "" && priorityChanged != "" && completedChanged != "" && controller.completedSegmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment && controller.prioritySegmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment {
                let changedData : [String] = [completedChanged, descriptionChanged, priorityChanged, timeDateAdded]
                if titleChanged == taskTitlePassed {
                    applicationDelegate.dict_listData.setValue(changedData, forKey: titleChanged)
                }
                    
                else {
                    applicationDelegate.dict_listData.removeObject(forKey: taskTitlePassed)
                    applicationDelegate.dict_listData.setValue(changedData, forKey: titleChanged)
                }
                tasksTableView.reloadData()
                self.navigationController!.popViewController(animated: true)
                
            }
            else {
                //all forms were not filled
                let alertController = UIAlertController(title: "All Fields Not Filled",
                                                        message: "Please fill all of the required information",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        let rowNumber = (indexPath as NSIndexPath).row
        //let taskName = taskNames[rowNumber]
        taskNames = applicationDelegate.dict_listData.allKeys as! [String]
        taskNames.sort { $0 < $1 }
        let taskName = taskNames[rowNumber]
        //taskNames = applicationDelegate.dict_task_data.allKeys as! [String]
        let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
        let taskArray = taskData as! [String]
        //array data
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNumber = (indexPath as NSIndexPath).row
        let taskName = taskNames[rowNumber]
        let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
        let taskArray = taskData as! [String]
        dataToPassed = taskArray
        taskTitlePassed = taskName
        performSegue(withIdentifier: "toDoItem", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
          if editingStyle == .delete {
            let rowNumber = (indexPath as NSIndexPath).row
            taskNames = applicationDelegate.dict_listData.allKeys as! [String]
            taskNames.sort { $0 < $1 }
            let taskToBeDeleted = taskNames[rowNumber]
            applicationDelegate.dict_listData.removeObject(forKey: taskToBeDeleted)
            tasksTableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let rowNumber = (indexPath as NSIndexPath).row
        let taskName = taskNames[rowNumber]
        let taskData : AnyObject? = applicationDelegate.dict_listData[taskName] as AnyObject
        let taskArray = taskData as! [String]
        dataToPassed = taskArray
        taskTitlePassed = taskName
        performSegue(withIdentifier: "editTask", sender: self)

        
    }
    
 ///-----------------
    
    func addTaskViewController(_ controller: AddTaskViewController, didFinishWithSave save: Bool) {
        if save {
            let titleOfTaskAdded : String =  controller.titleTextField.text!
            let descriptionOfTaskAdded : String = controller.descriptionTextView.text
            //time logic
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            let dateAndTime = controller.dueDate.date
            let timeDateAdded = dateFormatter.string(from: dateAndTime)
            let priorityAdded = controller.priorityType
            let completedAdded = controller.completedType
            
            if titleOfTaskAdded != "" && descriptionOfTaskAdded != "" && timeDateAdded != "" && priorityAdded != "" && completedAdded != "" && controller.completedSegmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment && controller.prioritySegmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment {
                let addedData : [String] = [completedAdded, descriptionOfTaskAdded, priorityAdded, timeDateAdded]
                applicationDelegate.dict_listData.setValue(addedData, forKey: titleOfTaskAdded)
                tasksTableView.reloadData()
                self.navigationController!.popViewController(animated: true)
            }
            else {
                //all forms were not filled
                let alertController = UIAlertController(title: "All Fields Not Filled",
                                                        message: "Please fill all of the required information",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    func addTask( _ sender: AnyObject) {
        performSegue(withIdentifier: "addTask", sender: self)
    }
    
    ///GETS CALLED BEFORE SEGUE 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoItem" {
            let taskReadOnlyViewController : TaskReadOnlyViewController = segue.destination as! TaskReadOnlyViewController
            taskReadOnlyViewController.dataPassed = dataToPassed
            taskReadOnlyViewController.titlepassed = taskTitlePassed
            
        }
        if segue.identifier == "editTask" {
            let changeTaskViewController : ChangeTaskViewController = segue.destination as! ChangeTaskViewController
            changeTaskViewController.dataPassed = dataToPassed
            changeTaskViewController.titlePassed = taskTitlePassed
            changeTaskViewController.delegate = self
        }
        if segue.identifier == "addTask" {
            let addTaskViewController : AddTaskViewController = segue.destination as! AddTaskViewController
            addTaskViewController.delegate = self
            
        }
    }

}
