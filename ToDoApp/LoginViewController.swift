//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 04/12/2024.
//
import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let Correctemail = "kuba@gmail.com"
    let Correctpassword = "kuba"
    var isLoggedIn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("logowanie")
        print("testowanie")
        print("testowanie2")
        print("testowanie3  ss")
        
    }
    
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
    
        
        print("nacisniety przycisk")
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                print("❌ self jest nil, nie można zmienić isLoggedIn")
                return
            }
            
            if let error = error {
                        print("🚨 Błąd logowania: \(error.localizedDescription)")
                    } else {
                        print("✅ Logowanie powiodło się!")
                        strongSelf.performSegue(withIdentifier: "goToLoggedIn", sender: strongSelf)
                    }
            
            //print("✅ Logowanie powiodło się!")
            
//            DispatchQueue.main.async {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)  // Upewnij się, że "Main" to nazwa Twojego storyboarda
//                  if let nextViewController = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as? LoggedInViewController {
//                      strongSelf.navigationController?.pushViewController(nextViewController, animated: true)
//                  } else {
//                      print("❌ Błąd: Nie udało się stworzyć LoggedInViewController")
//                  }
//            }
            print("koniec procesu")
        }
        
        
        
    }
}
