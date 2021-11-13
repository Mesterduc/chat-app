//
//  LoginController.swift
//  chat app
//
//  Created by Duc hong cai on 13/11/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
//    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(loginLabel)
        view.addSubview(loginView)
        loginView.addSubview(emailTextView)
        loginView.addSubview(passwordTextView)
        view.addSubview(loginButton)
        
        setup()
        
    }
    
    private let loginView:UIView = {
      let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Live Chat"
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let emailTextView: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.layer.cornerRadius = 15
        email.textAlignment = .center
        email.layer.borderColor = UIColor.black.cgColor
        email.layer.borderWidth = 1.5
        email.backgroundColor = .white
        email.autocorrectionType = .no
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    private let passwordTextView: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.layer.cornerRadius = 15
        password.textAlignment = .center
        password.layer.borderColor = UIColor.black.cgColor
        password.layer.borderWidth = 1.5
        password.backgroundColor = .white
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 10/255, blue: 10/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func loginUser() {
        guard let email = emailTextView.text, !email.isEmpty, let password = passwordTextView.text, !password.isEmpty else {
            print("No user with that information")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
            if let error = error {
                print(error)
                return
            }

            print("you have signed in")
            self!.dismiss(animated: true, completion: nil)

        }
    }
    
    func setup(){
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginView.heightAnchor.constraint(equalToConstant: 120),

            emailTextView.widthAnchor.constraint(equalTo: loginView.widthAnchor),
            emailTextView.heightAnchor.constraint(equalToConstant: 50),
            emailTextView.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            emailTextView.topAnchor.constraint(equalTo: loginView.topAnchor),
            emailTextView.bottomAnchor.constraint(equalTo: passwordTextView.topAnchor, constant: -20),

            passwordTextView.widthAnchor.constraint(equalTo: loginView.widthAnchor),
            passwordTextView.heightAnchor.constraint(equalToConstant: 50),
            passwordTextView.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 15),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }


}