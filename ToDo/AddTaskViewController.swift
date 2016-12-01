//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 11/30/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

protocol AddTaskViewControllerProtocol {
    func addTaskViewController(_ controller: AddTaskViewController, didFinishWithSave save: Bool)
}

class AddTaskViewController: UIViewController {

    var delegate: AddTaskViewControllerProtocol?
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var priorityType : String = ""
    var completedType : String = ""
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var dueDate: UIDatePicker!
    @IBOutlet var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet var completedSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"
        self.hideKeyboardWhenTappedAround()

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AddTaskViewController.save(_:)))
        self.navigationItem.rightBarButtonItem = saveButton

        prioritySegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        completedSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.descriptionTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func priorityTypeSelected(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex {
        case 0:
            priorityType = "Low"
        case 1:
            priorityType = "Normal"
        case 2:
            priorityType = "High"
        default:
            return
            
        }
    }
    
        @IBAction func completedTypeSelected(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                completedType = "YES"
            case 1:
                completedType = "NO"
          
            default:
                return
            }
    }
    
    func save(_ sender: AnyObject) {
        delegate!.addTaskViewController(self, didFinishWithSave: true)
    }
  
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
}
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

