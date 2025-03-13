//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 31/05/2025.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var checkbox: UIButton? // ← jeśli używasz `checkbox`
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkbox?.configuration = nil
        checkbox?.setImage(nil, for: .normal)
        taskLabel.text = nil
        checkbox?.removeTarget(nil, action: nil, for: .allEvents)
    }
}
