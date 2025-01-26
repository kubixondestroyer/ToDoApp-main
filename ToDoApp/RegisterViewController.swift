//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 04/12/2024.
//
import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("rejestracja")
        print("rejestracja 2")
        print("testowe 3")
        
//        handle = Auth.auth().addStateDidChangeListener { auth, user in
//          // ...
//        }
    }
    
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      // ...
    } //rejesterowanie nowych uzytkowników


}
