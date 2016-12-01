//
//  TaskReadOnlyViewController.swift
//  ToDoList
//
//  Created by Jesus Fabian on 11/30/16.
//  Copyright © 2016 Jesus Fabian All rights reserved.
//

import UIKit

class TaskReadOnlyViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priorityLabel: UILabel!
    @IBOutlet var completedLabel: UILabel!
    var dataPassed = [String]()
    var titlepassed : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do Item"
        titleLabel.text = titlepassed
        completedLabel.text = dataPassed[0]
        descriptionTextView.text = dataPassed[1]
        priorityLabel.text = dataPassed[2]
        timeLabel.text = dataPassed[3]
    }
    override func viewDidAppear(_ animated: Bool) {
        self.descriptionTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
