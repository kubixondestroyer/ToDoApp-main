//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Jakub Chrobok on 25/06/2025.
//

import FirebaseCore
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


class FirstViewController: UIViewController {
    
    let backgroundHeaderView = UIView()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello Todo List")
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
        setupGradientHeader()
    }
    
    func setupGradientHeader() {
         // Dodaj widok tła
         backgroundHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 800)
         view.insertSubview(backgroundHeaderView, at: 0)

         
         // Gradient
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.red.cgColor]
         gradientLayer.startPoint = CGPoint(x: 0, y: 0)
         gradientLayer.endPoint = CGPoint(x: 1, y: 1)
         gradientLayer.frame = backgroundHeaderView.bounds
         backgroundHeaderView.layer.insertSublayer(gradientLayer, at: 0)
         
         // Maska skośna
         let maskPath = UIBezierPath()
         maskPath.move(to: CGPoint(x: 0, y: 0))
         maskPath.addLine(to: CGPoint(x: backgroundHeaderView.frame.width, y: 0))
         maskPath.addLine(to: CGPoint(x: backgroundHeaderView.frame.width, y: 450))
         maskPath.addLine(to: CGPoint(x: 0, y: 320)) // niższy koniec — skos
         maskPath.close()
         
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = maskPath.cgPath
         backgroundHeaderView.layer.mask = shapeLayer
     }
    
    @IBAction func loginButton(_ sender: Any) {
        print("przechodze do logowania")
    }
    
    @IBAction func registerButton(_ sender: Any) {
        print("przechodze do rejestracji")
    }
}
