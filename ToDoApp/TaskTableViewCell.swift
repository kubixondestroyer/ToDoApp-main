//
//  Untitled.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 30/03/2025.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!

    var isChecked: Bool = false {
        didSet {
            updateCheckboxImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        updateCheckboxImage()
    }

    @objc func checkboxTapped() {
        isChecked.toggle()
    }

    private func updateCheckboxImage() {
        let imageName = isChecked ? "checkmark.square" : "square"
        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
