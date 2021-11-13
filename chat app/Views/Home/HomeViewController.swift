//
//  ViewController.swift
//  chat app
//
//  Created by Duc hong cai on 13/11/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(logoutButton)
        view.addSubview(msgTextField)
        
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        
        handle = FirebaseAuth.Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {
                
                 self.transitionToLogin()
                return
            }
            print(user.uid)
        }
    }
    
    private func transitionToLogin(){
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 10/255, blue: 10/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func logoutUser() {
        do {
           try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    private let msgTextField: UITextField = {
        let msg = UITextField()
        msg.placeholder = "Type message"
        msg.layer.borderColor = UIColor.black.cgColor
        msg.layer.borderWidth = 1.5
        msg.backgroundColor = .gray
        msg.addPadding(.left(10))
//        msg.autocorrectionType = .no
        msg.translatesAutoresizingMaskIntoConstraints = false
        
        return msg
    }()
    
    private func setup() {
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            
            msgTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            msgTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            msgTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            msgTextField.heightAnchor.constraint(equalToConstant: 50),
            
        
        ])
    }


}



