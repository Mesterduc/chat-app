//
//  SigninViewController.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import UIKit
import FirebaseAuth

class UsernameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(loginLabel)
        view.addSubview(usernameView)
        usernameView.addSubview(usernameTextField)
        usernameView.addSubview(confirmButton)
        
        setup()
        
    }
    
    private let usernameView:UIView = {
      let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a Username"
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Username"
        email.layer.cornerRadius = 15
        email.textAlignment = .center
        email.layer.borderColor = UIColor.black.cgColor
        email.layer.borderWidth = 1.5
        email.backgroundColor = .white
        email.autocorrectionType = .no
        email.translatesAutoresizingMaskIntoConstraints = false
        
        
        return email
    }()
    
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 10/255, blue: 10/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(updateUsername), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func updateUsername() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            print("Username field is emty")
            return
        }
        
        let changeRequest = FirebaseAuth.Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { error in
            if error == nil {
                print("Cant Change name")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setup(){
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: usernameView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            usernameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: usernameView.topAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            usernameTextField.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -10),
            
            confirmButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            confirmButton.widthAnchor.constraint(equalTo: usernameView.widthAnchor, multiplier: 0.33),
            confirmButton.centerXAnchor.constraint(equalTo: usernameView.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor),
        ])
    }


}

