//
//  DueDateTableViewController.swift
//  ToDoList
//
//  Created by Jesus Fabianon 12/1/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class DueDateTableViewController: UITableViewController {
    
    @IBOutlet var toDoTableView: UITableView!
    
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var toDoNames = [String]()
    
    var toDoTitle = String()
    var toDoTime = String()
    var checked = String()
    var todoData = String()
    
    var dataToPass = [String](repeating: "", count: 4)
    var titlePassed : String = ""
    var dueDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Due Date List"
       
        toDoNames = applicationDelegate.dict_listData.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        dueDates = [String](repeating: "", count: toDoNames.count)
        var count = 0
        while count != toDoNames.count{
            
            let name = toDoNames[count]
            let lists : AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
            let dataArray = lists as! [String]
            
            dueDates[count] = dataArray[3]
            
            count += 1
        }
        
        dueDates.sort { $0 < $1 }
        count = 0
        var temp = [String](repeating: "", count: toDoNames.count)
        while count != dueDates.count{
            
            let date = dueDates[count]
            var next = 0
            while next != toDoNames.count{
                let name = toDoNames[next]
              
                let lists: AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
                let dataArray = lists as! [String]
                if (date == dataArray[3])
                {
                    temp[count] = toDoNames[next]
                    break
                }
                next += 1
            }
            count += 1
        }
        toDoNames = temp
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        toDoNames = applicationDelegate.dict_listData.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        dueDates = [String](repeating: "", count: toDoNames.count)
        var count = 0
        while count != toDoNames.count{
            
            let name = toDoNames[count]
            let lists : AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
            let dataArray = lists as! [String]
            
            dueDates[count] = dataArray[3]
            
            count += 1
        }
        
        dueDates.sort { $0 < $1 }
        count = 0
        var temp = [String](repeating: "", count: toDoNames.count)
        while count != dueDates.count{
            
            let date = dueDates[count]
            var next = 0
            while next != toDoNames.count{
                let name = toDoNames[next]
                //let lists: AnyObject? = appDel.dict_toDoList[name] as AnyObject
                let lists : AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
                let dataArray = lists as! [String]
                if (date == dataArray[3])
                {
                    temp[count] = toDoNames[next]
                    break
                }
                next += 1
            }
            count += 1
        }
        toDoNames = temp
        toDoTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = (indexPath as NSIndexPath).row
        
        let name = toDoNames[row]
        
        let lists : AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
        let dataArray = lists as! [String]
        
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = dataArray[3]
        if (dataArray[2] == "Low")
        {
            
            cell.textLabel!.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }
        else if dataArray[2] == "High"
        {
            cell.textLabel!.textColor = UIColor.red
            cell.detailTextLabel?.textColor = UIColor.red
        }
        else if dataArray[2] == "Normal"
        {
                cell.textLabel!.textColor = UIColor.brown
                cell.detailTextLabel?.textColor = UIColor.brown
            
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
        
        //let lists: AnyObject? = appDel.dict_toDoList[name] as AnyObject
        let lists : AnyObject? = applicationDelegate.dict_listData[name] as AnyObject
        let dataArr = lists as! [String]
        
        dataToPass[0] = dataArr[0]
        dataToPass[1] = dataArr[1]
        dataToPass[2] = dataArr[2]
        dataToPass[3] = dataArr[3]
        titlePassed = name
        
        
        performSegue(withIdentifier: "toBeDoneShowTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "toBeDoneShowTask" {
            let taskReadOnlyViewController : TaskReadOnlyViewController = segue.destination as! TaskReadOnlyViewController
            taskReadOnlyViewController.dataPassed = dataToPass
            taskReadOnlyViewController.titlepassed = self.titlePassed
        }
    }
    
}

