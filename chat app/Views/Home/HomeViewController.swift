//
//  ViewController.swift
//  chat app
//
//  Created by Duc hong cai on 13/11/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    private let vm = HomeViewModel()
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        view.addSubview(logoutButton)
        view.addSubview(msgTextField)
        view.addSubview(tableView)
        
        db.collection("chat").getDocuments() { (result, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            guard let result = result else {
                print("no data")
                return
            }
            
                for document in result.documents {
                    let data = try? document.data(as: Chat.self)
                    
                    
//                    print(data["user"] as! String)
                    print(data!)
                    
//                    for data in document.data() {
//                        print(data["user"] as? String ?? "")
//                        if data.key == "user" {
//                            Chat(message: <#T##String#>, timestamp: <#T##Timer#>, user: <#T##String#>)
//                            self.vm.hej.append(data)
//                            self.tableView.reloadData()
//                        }
//                    }
                }
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        db.collection("chat")
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(label)
        label.text = self.vm.chat[indexPath.row]
//        print(self.hej[indexPath.row])
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            label.topAnchor.constraint(equalTo: cell.topAnchor),
            
        ])
        
        return cell
    }


}



