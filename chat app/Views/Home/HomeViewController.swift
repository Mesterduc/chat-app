//
//  ViewController.swift
//  chat app
//
//  Created by Duc hong cai on 13/11/2021.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    let vm = HomeViewModel()
    var handle: AuthStateDidChangeListenerHandle?
    private var cancellables = Set<AnyCancellable>()
    var activeUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        view.addSubview(logoutButton)
        view.addSubview(msgTextField)
        view.addSubview(tableView)
        view.addSubview(sendMessage)
        
        tableView.delegate = self
        tableView.dataSource = self
        updateTableView()
        
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        
        handle = FirebaseAuth.Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {
                self.activeUser = ""
                self.transitionToLogin(viewController: LoginViewController())
                return
            }
            
            guard let username = user.displayName else {
                self.transitionToLogin(viewController: UsernameViewController())
                return
            }
            
            self.activeUser = username
//            print(username)
//            print("hello")
        }
    }
    
    private func updateTableView(){
        self.vm.$chat
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
    private func transitionToLogin(viewController: UIViewController){
        let vc = UINavigationController(rootViewController: viewController)
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    private let msgTextField: UITextField = {
        let msg = UITextField()
        msg.placeholder = "Type message"
        msg.layer.borderColor = UIColor.black.cgColor
        msg.layer.borderWidth = 1.5
        msg.backgroundColor = .gray
        msg.addPadding(.left(10))
        msg.translatesAutoresizingMaskIntoConstraints = false
        
        return msg
    }()
    
    private let sendMessage: UIButton = {
        let sendButton = UIButton()
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.backgroundColor = .gray
        
        sendButton.addTarget(self, action: #selector(send2), for: .touchUpInside)
        
        return sendButton
    }()
    @objc private func send2() {
        if let text = msgTextField.text, text != "" {
            self.vm.sendMessage(message: text, name: self.activeUser)
        }else {
            print("Text is emty")
        }
    }
    
    private func setup() {
        NSLayoutConstraint.activate([
            //            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: msgTextField.topAnchor),
            
            msgTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            msgTextField.trailingAnchor.constraint(equalTo: sendMessage.leadingAnchor, constant: -10),
            msgTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            msgTextField.heightAnchor.constraint(equalToConstant: 50),
            
            sendMessage.leadingAnchor.constraint(equalTo: msgTextField.trailingAnchor, constant: 10),
            sendMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sendMessage.heightAnchor.constraint(equalToConstant: 50),
            sendMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            
            
        ])
    }
}





