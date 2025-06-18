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
import FirebaseFirestore

class LoggedInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    //   @IBOutlet weak var textField: UITextField!
    
    var selectedTaskID : Int = 0
    var selectedFirestoreID : String = ""
    var selectedTaskText: String = ""
    @IBAction func editTask(_ sender: UIButton) {
        
        if selectedTaskIDs.count == 0 {
            showAlert(title: "Błąd", message:"Nie zaznaczyłeś zadania!")
                return
        }
        if selectedTaskIDs.count > 1 {
                showAlert(title: "error", message: "You checked more than one task to edit")
                return
        }

        guard let taskID = selectedTaskIDs.first,
                 let index = taskIDs.firstIndex(of: taskID) else {
               showAlert(title: "Błąd", message: "Nie można znaleźć zadania.")
               return
            }
                      
            selectedTaskText = tasks[index]
            selectedFirestoreID = taskIDs[index]
        
            print("testuje teraz")
            print(selectedTaskText)
              
                      
//        self.performSegue(withIdentifier: "editTask", sender: self)
        
        self.performSegue(withIdentifier: "editTask", sender: self)
        
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask", let destinationVC = segue.destination as? EditTodoController {
           
           destinationVC.textFromPreviousScreen = selectedTaskText
            destinationVC.textFromPreviousScreen2 = selectedFirestoreID
           
       }
        
    }
    
    
    
    var tasks: [String] = []
    let db = Firestore.firestore()
    
    var taskIDs: [String] = []  // przechowuje ID z dokumentów Firestore
    var selectedTaskIDs: Set<String> = []   // indeks zaznaczonych zadan
    var didJustRemoveTasks = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self // ask me for data
        tableView.delegate = self // ask me for interaction
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40), // Zostaw miejsce na przyciski
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        guard let user = Auth.auth().currentUser else {
            print("brak zalogowanego uzytkownika")
            return
        }
        print("zalogowano")
        
        // pobieranie danych z Firestore
        
        let docRef = db.collection("users")
            .document(user.uid)
            .collection("todos")
            .order(by: "timestamp", descending: false)
        
        

        docRef.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Brak dokumentów albo błąd: \(error?.localizedDescription ?? "nieznany błąd")")
                print("Aktualne selectedTaskIDs: \(self.selectedTaskIDs)")
                return
            }

            self.tasks = documents.compactMap { $0["text"] as? String }
            self.taskIDs = documents.map { $0.documentID}
            
            
            self.selectedTaskIDs = self.selectedTaskIDs.intersection(self.taskIDs) // przefiltruj zaznaczone ID tylko od tych, które nadal
            //sa w liscie
            if self.didJustRemoveTasks {
                self.selectedTaskIDs.removeAll()
                self.didJustRemoveTasks = false
            } else {
                // Upewnij się, że zaznaczone ID nadal istnieją
                self.selectedTaskIDs = self.selectedTaskIDs.intersection(Set(self.taskIDs))
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Aktualne selectedTaskIDs: \(self.selectedTaskIDs)")

            }
        }
        
    }
    
    
        
    @IBAction func removeFromList(_ sender: UIButton) {
        print("nacisniete")
        
        guard let user = Auth.auth().currentUser else {return}
        
        let userTasksRef = db.collection("users").document(user.uid).collection("todos")
        
        //let indexToRemove = selectedTaskIDs.sorted(by: >)  // sortowanie do konca // jest to traktowane jako String

        
            for docID in selectedTaskIDs{
                userTasksRef.document(docID).delete(){ error in
                    if let error = error {
                        print("bład przy usuwaniu dokumentu: \(error)")
                    }else{
                        print( "Usunieto zadanie z ID: \(docID)")
                    }
                }
            }
            didJustRemoveTasks = true
            selectedTaskIDs.removeAll()
            print("oto id zaznaczonych jak na razie tasków")
            print(selectedTaskIDs)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
        
        
        
        @IBAction func addToList(_ sender: UIButton) { // finished
            print("les's add new todo task")
            self.performSegue(withIdentifier: "addNewTodo", sender: self)
        }
        
    
    
        @IBAction func checkboxPressed(_ sender: UIButton) { // finished

            let index = sender.tag
            
            
            guard index < tasks.count else {
                print("Błąd: Próbujesz zaznaczyć nieistniejącą komórkę \(index))")
                return
            }
            let taskID = taskIDs[index]
                if selectedTaskIDs.contains(taskID) {
                    selectedTaskIDs.remove(taskID)
                    print("Odznaczono komórkę \(taskID)")
                } else {
                    selectedTaskIDs.insert(taskID)
                    print("Zaznaczono komórkę \(taskID)")
                }

                //var config = sender.configuration ?? UIButton.Configuration.plain()
                var config = UIButton.Configuration.filled()
                config.cornerStyle = .capsule
                config.image = selectedTaskIDs.contains(taskID) ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
                config.baseBackgroundColor = selectedTaskIDs.contains(taskID) ? .systemBlue : .clear
                config.baseForegroundColor = selectedTaskIDs.contains(taskID) ? .white : .gray
                sender.configuration = config
        }
        
        
    
    
        @IBAction func buttonPressed(_ sender: Any) { // so far not to touch
            print("save ToDo list")
        }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(tasks.count)
            print("tutaj jest liczba taskow")
            return tasks.count  // taks.count gives us knowledge, how many cell are and which cell count we are currently in
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
            
            guard
                indexPath.row < tasks.count,
                indexPath.row < taskIDs.count,
                let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell
                else {
                print("blad: indexPath.row poza zakresem! \(indexPath.row)")
                return UITableViewCell()
                }
                cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

                let taskText = tasks[indexPath.row]
                let taskID = taskIDs[indexPath.row]
                let isSelected = selectedTaskIDs.contains(taskID)

            cell.taskLabel.text = taskText
            if let checkbox = cell.checkbox {
                    checkbox.tag = indexPath.row
                    checkbox.removeTarget(nil, action: nil, for: .allEvents)
                    checkbox.addTarget(self, action: #selector(checkboxPressed(_:)), for: .touchUpInside)

                    var config = UIButton.Configuration.filled()
                    config.cornerStyle = .capsule
                    config.image = selectedTaskIDs.contains(taskID) ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
                    config.baseBackgroundColor = selectedTaskIDs.contains(taskID) ? .systemBlue : .clear
                    config.baseForegroundColor = selectedTaskIDs.contains(taskID) ? .white : .gray
                    checkbox.configuration = config

                    //checkbox.configuration = config
                }
//                cell.taskLabel.text = taskText
//                cell.checkbox.tag = indexPath.row
//                cell.checkbox.removeTarget(nil, action: nil, for: .allEvents)
//                cell.checkbox.addTarget(self, action: #selector(checkboxPressed(_:)), for: .touchUpInside)
//
//                var config = UIButton.Configuration.filled()
//                config.cornerStyle = .capsule
//                config.image = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                config.baseBackgroundColor = isSelected ? .systemBlue : .clear
//                config.baseForegroundColor = isSelected ? .white : .gray
//                cell.checkbox.configuration = config

                return cell
          
        }
        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
    }
