//
//  Profile1ViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 18/06/2025.
//



import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase



class Profile1ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emtpyLabel1: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emptyLabel2: UILabel!
    
    @IBOutlet weak var joinTimeLabel: UILabel!
    
    
    
    
//    override func viewDidLoad() {
//          super.viewDidLoad()
//          print("Profile 11234567")
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        emailLabel.translatesAutoresizingMaskIntoConstraints = false
//        joinTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([nameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5)])
//        NSLayoutConstraint.activate([emailLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9)])
//        NSLayoutConstraint.activate([joinTimeLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2)])
//
//      }
    override func viewDidLoad() {
        super.viewDidLoad()

        let labels = [nameLabel, emtpyLabel1, emailLabel, emptyLabel2, joinTimeLabel]

        for label in labels {
            label?.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label!.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
            ])

            label?.textAlignment = .center
            label?.numberOfLines = 0 // jeśli tekst jest dłuższy
        }
    }
    
    
    
      override func viewDidAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          // Ukrywanie paska nawigacyjnego, ale bez animacji, by uniknąć migotania
          self.navigationController?.setNavigationBarHidden(true, animated: false)
          
          super.viewWillDisappear(animated)
          // Przywracanie paska nawigacyjnego, kiedy wracamy do poprzedniego widoku
          self.navigationController?.setNavigationBarHidden(false, animated: false)
      }


  

//    func loadUserInfo() {
//        guard let user = Auth.auth().currentUser else {
//            emailLabel.text = "Nie zalogowano"
//            // now I have to get DOC.ID
//            return
//        }
//        
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(user.uid)
//        
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()
//                let email = data?["email"] as? String ?? "Nie ma emaila"
//                let username = data?["username"] as? String ?? "Nie ma usernamea"
//                let timestamp = data?["timestamp"] as? Timestamp
//                let memberSince = timestamp?.dateValue() ?? Date()
//                
//                // formatowanie daty
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .medium
//                
//                
//                DispatchQueue.main.async {
//                               self.emailLabel.text = "Email: \(email)"
//                               self.nameLabel.text = "Nazwa: \(username)"
//                               self.memberSinceLabel.text = "Z nami od: \(dateFormatter.string(from: memberSince))"
//                           }
//                
//            } else{
//                print("nie znaleziono dokumentu uzytkownika")
//            }
//        }
        
        
//        print(user.email ?? "Nie zalogowano")
//        print(user.uid)
//        
//        
//        let taskRef = Firestore.firestore()
//            .collection("users")
//            .document(user.uid)
//            .collection("todos")
//            
// 
//    }
}
