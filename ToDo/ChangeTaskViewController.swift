//
//  ChangeTaskViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 11/30/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

protocol ChangeTaskViewControllerProtocol {
    func changeTaskViewController(_ controller: ChangeTaskViewController, didFinishWithSave save: Bool)
}
class ChangeTaskViewController: UIViewController {

    
    var delegate: ChangeTaskViewControllerProtocol?
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var dueDate: UIDatePicker!
    @IBOutlet var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet var completedSegmentedControl: UISegmentedControl!
    
    
    var dataPassed = [String]()
    var titlePassed : String = ""
    var priorityType : String = ""
    var completedType : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change"
        self.hideKeyboardWhenTappedAround()
        titleTextField.text = titlePassed
        descriptionTextView.text = dataPassed[1]
        priorityType = dataPassed[2]
        completedType = dataPassed[0]
        prioritySegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        completedSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ChangeTaskViewController.save(_:)))
        self.navigationItem.rightBarButtonItem = saveButton

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.descriptionTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func save(_ sender: AnyObject) {
        delegate!.changeTaskViewController(self, didFinishWithSave: true)
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

}
