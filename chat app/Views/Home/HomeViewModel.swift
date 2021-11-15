//
//  HomeViewModel.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

enum LoginState: String {
    case notLogin, noUsernamer
}
class HomeViewModel {
    private var db = Firestore.firestore()
    @Published var chat: [Chat] = []
    var handle: AuthStateDidChangeListenerHandle?
    var activeUser = ""
    var userState = ""
    
    
    init( ) {
        fetchChat()
        checkLoginState()
    }
    
    func sendMessage(message: String, name: String){
        db.collection("chat").addDocument(data: [
            "user": self.userState,
            "timestamp": Timestamp(date: Date()),
            "message": message,
        ])
    }
    
    func checkLoginState() {
        handle = FirebaseAuth.Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.activeUser = ""
//                self.transitionTo(viewController: LoginViewController())
                self.userState = LoginState.notLogin.rawValue
                print("hello")
                return
            }
            guard let username = auth.currentUser?.displayName else {
//                self.transitionTo(viewController: UsernameViewController())
                self.userState = LoginState.noUsernamer.rawValue
                print("hello")
                return
            }
            
            self.userState = username
            print("hello \(username)")
            
//            self.activeUser = username
//            self.tableView.reloadData()
        }
    }
    
    func removeLoginState(){
        self.activeUser = ""
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func signOut() {
        do {
           try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func fetchChat() {
        db.collection("chat").order(by: "timestamp", descending: true).addSnapshotListener({ result, err in
            self.chat = []
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
                self.chat.append(data!)
            }
        })
    }
}
