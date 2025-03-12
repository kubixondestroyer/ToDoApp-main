//
//  ViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 04/12/2024.
//

import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    var tasks: [String] = ["make a dinner", "go to gym", "eat breakfast"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self // ask me for data
        tableView.delegate = self // ask me for interaction
        print("zalogowano")
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("nacisniety")
        
    }
    

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    


}

