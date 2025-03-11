//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 04/12/2024.
//
import FirebaseCore
import FirebaseFirestore
import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var isRegistered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("rejestracja")
//        print("rejestracja 2")
//        print("testowe 3")
        

    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        print("wcisniety przycisk")
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        print(email)
        print(password)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("error")
                return
            }else{
                
                
                print("udalo sie")
                
                DispatchQueue.main.async {
                    self.isRegistered = true
                    print("🎉 isRegistered = \(self.isRegistered)")
                }
            }
            
            guard let user = authResult?.user else { return }
            let db = Firestore.firestore()
            // dodajemy uzytkownika do firestore, wraz z rejestracja
            
            db.collection("users").document(user.uid).setData([
                       "email": email,
                       "username": "NowyUżytkownik",
                       "score": 0 //tutaj dodaje dowolne pola, które chce, zeby Firestore dodawał
                   ]) { error in
                       if let error = error {
                           print("❌ Błąd zapisu danych: \(error.localizedDescription)")
                       } else {
                           print("✅ Dane użytkownika zapisane w Firestore!")
                       }
                   }
           

            
        }
    }


}
