//
//  AddTodoController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 30/03/2025.
//

import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddTodoController: UIViewController{
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let data : [String] = ["test data1"]
    let db = Firestore.firestore()
    
    @IBOutlet weak var newTaskField: UITextField!
    @IBAction func addTodo(_ sender: UIButton) { // sprawdzam ponizej, czy uzytkownik jest zalogowany oraz czy
        //pole tekstowe jest puste
        
        guard let user = Auth.auth().currentUser else {
            print("brak zalogowanego uzytkownika")
            return
        }
       guard let taskText = newTaskField.text, !taskText.isEmpty else {
            print("puste pole")
           return
        }
        Task { @MainActor in
              let todoData: [String: Any] = [
                  "text": taskText,
                  "timestamp": Timestamp(date: Date()),
                  "completed": false
              ]
              
              do {
                  try await db.collection("users").document(user.uid).collection("todos").addDocument(data: todoData)
                  print("Zadanie zapisane!")
                  newTaskField.text = "" // Wyczyść pole tekstowe po zapisaniu
              } catch {
                  print("Błąd zapisu: \(error.localizedDescription)")
              }
          }
      }
        
        
        
        
        

    

}
