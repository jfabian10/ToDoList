//
//  PriorityTableViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 12/1/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class PriorityTableViewController: UITableViewController {
    
    
    @IBOutlet var toDoListTableView: UITableView!
    
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var toDoNames = [String]()
    var toDoTitle = String()
    var toDoTime = String()
    var checked = String()
    var todoData = String()
    
    var dataToPass = [String](repeating: "", count: 4)
    //var dataToPass = [String]()
    var titlePassed : String = ""
    
    var high = 0
    var normal = 0
    var low = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Priority List"
        
        toDoNames = applicationDelegate.dict_listData.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        
        var highList = [String](repeating: "", count: toDoNames.count)
        var normalList = [String](repeating: "", count: toDoNames.count)
        var lowList = [String](repeating: "", count: toDoNames.count)
        
        var counter = 0
        while counter != toDoNames.count
        {
            let name = toDoNames[counter]
            let lists: AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
            let dataArray = lists as! [String]
            if dataArray[2] == "High"
            {
                highList[high] = toDoNames[counter]
                high += 1
            }
            else if dataArray[2] == "Normal"
            {
                normalList[normal] = toDoNames[counter]
                normal += 1
            }
            else
            {
                lowList[low] = toDoNames[counter]
                low += 1
            }
            counter += 1
            
        }
        counter = 0
        while counter != high
        {
            toDoNames[counter] = highList[counter]
            counter += 1
        }
        var start = 0
        while start != normal
        {
            toDoNames[counter] = normalList[start]
            start += 1
            counter += 1
        }
        var next = 0
        while next != low
        {
            toDoNames[counter] = lowList[next]
            next += 1
            counter += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toDoNames = applicationDelegate.dict_listData.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        
        
        var highList = [String](repeating: "", count: toDoNames.count)
        var normalList = [String](repeating: "", count: toDoNames.count)
        var lowList = [String](repeating: "", count: toDoNames.count)
        
        var counter = 0
        high = 0
        normal = 0
        low = 0
        while counter != toDoNames.count
        {
            let name = toDoNames[counter]
            let lists: AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
            let dataArray = lists as! [String]
            if dataArray[2] == "High"
            {
                highList[high] = toDoNames[counter]
                high += 1
            }
            else if dataArray[2] == "Normal"
            {
                normalList[normal] = toDoNames[counter]
                normal += 1
            }
            else
            {
                lowList[low] = toDoNames[counter]
                low += 1
            }
            counter += 1
            
        }
        counter = 0
        while counter != high
        {
            toDoNames[counter] = highList[counter]
            counter += 1
        }
        var start = 0
        while start != normal
        {
            toDoNames[counter] = normalList[start]
            start += 1
            counter += 1
        }
        var next = 0
        while next != low
        {
            toDoNames[counter] = lowList[next]
            next += 1
            counter += 1
        }
        toDoListTableView.reloadData()
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
        return toDoNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = (indexPath as NSIndexPath).row
        
        let name = toDoNames[row]
        
        let lists: AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
        let dataArray = lists as! [String]
        //        var dataArray = moviesDict[row + 1]
        
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = dataArray[3]
        if (dataArray[2] == "Normal")
        {
            cell.textLabel!.textColor = UIColor.brown
            cell.detailTextLabel?.textColor = UIColor.brown
        }
        else if dataArray[2] == "High"
        {
            cell.textLabel!.textColor = UIColor.red
            cell.detailTextLabel?.textColor = UIColor.red
        }
        else if dataArray[2] == "Low"
        {
            cell.textLabel!.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }
        
        if (dataArray[0] == "NO")
        {
            cell.imageView!.image = #imageLiteral(resourceName: "CheckBox")
        }
        else
        {
            cell.imageView!.image = #imageLiteral(resourceName: "CheckedBox")
        }
        
        return cell
    }
    
    // Informs the table view delegate that the user tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        let name: String = toDoNames[rowNumber]
        
        let lists: AnyObject? = applicationDelegate.dict_listData[name] as AnyObject

        let dataArr = lists as! [String]
        
        
        dataToPass[0] = dataArr[0]
        dataToPass[1] = dataArr[1]
        dataToPass[2] = dataArr[2]
        dataToPass[3] = dataArr[3]
        titlePassed = name

        performSegue(withIdentifier: "toBeDoneShowTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
      
        //taskReadOnlyViewController.dataPassed = dataToPass
       // taskReadOnlyViewController.titlepassed = taskTitlePassed
        
        if segue.identifier == "toBeDoneShowTask" {
             let taskReadOnlyViewController : TaskReadOnlyViewController = segue.destination as! TaskReadOnlyViewController
            taskReadOnlyViewController.dataPassed = dataToPass
            taskReadOnlyViewController.titlepassed = self.titlePassed
            
        }
}


}
