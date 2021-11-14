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
    
    private let vm = HomeViewModel()
    var handle: AuthStateDidChangeListenerHandle?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        view.addSubview(logoutButton)
        view.addSubview(msgTextField)
        view.addSubview(tableView)
        
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
                
                self.transitionToLogin()
                return
            }
            print(user.uid)
        }
    }
    
    private func updateTableView(){
        self.vm.$chat
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
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
            msgTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            msgTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            msgTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
     
        cell.user.text = self.vm.chat[indexPath.row].user
        cell.message.text = self.vm.chat[indexPath.row].message
        
        NSLayoutConstraint.activate([
//            tableView.heightAnchor.constraint(equalToConstant: 50)

        ])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            
            cell.user.isHidden = !cell.user.isHidden
        }
        
    }
    
    
}



