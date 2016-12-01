//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Jesus Fabian on 11/30/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet var taskNameLabel: UILabel!
    @IBOutlet var taskDateLabel: UILabel!
    @IBOutlet var completedPicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
