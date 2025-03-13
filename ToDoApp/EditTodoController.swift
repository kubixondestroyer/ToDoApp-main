//
//  EditTodoController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 10/06/2025.
//

import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditTodoController: UIViewController {

    @IBOutlet weak var textToEdit2: UITextField!
    //var textToEdit: String?
    var todo: Todo!
    // values that are passed from LoggedInViewController
    var textFromPreviousScreen: String?  // task content based on the index
    var textFromPreviousScreen2: String?  // raw firestoreID

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("testuje")
        print(textFromPreviousScreen ?? "Nie ma textu")
        print("Firestore ID: \(textFromPreviousScreen2 ?? "brak ID")")
        
        
        
        
        view.backgroundColor = .systemBackground
        // konfiguracja labela
        
       // textToEdit.text = textFromPreviousScreen
        textToEdit2.text = textFromPreviousScreen
        //textToEdit2.numberOfLines = 0
        //textToEdit2.textAlignment = .center
       // textToEdit2.lineBreakMode = .byWordWrapping
       
     
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        guard
               let user = Auth.auth().currentUser,
               let docID = textFromPreviousScreen2,
               let updatedText = textToEdit2.text, !updatedText.isEmpty
           else {
               print("Brak wymaganych danych")
               return
           }
           
           let taskRef = Firestore.firestore()
               .collection("users")
               .document(user.uid)
               .collection("todos")
               .document(docID)
           
           taskRef.updateData([
               "text": updatedText
           ]) { error in
               if let error = error {
                   print("Błąd podczas aktualizacji: \(error)")
               } else {
                   print("Zaktualizowano pomyślnie")
                   DispatchQueue.main.async {
                       self.navigationController?.popViewController(animated: true)
                   }
               }
           }
    }
    //print(textFromPreviousScreen)
}
