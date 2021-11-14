//
//  HomeViewModel.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import Foundation
import FirebaseFirestore
import Combine

class HomeViewModel {
    private var db = Firestore.firestore()
//    var chat = [String]()
    @Published var chat: [Chat] = []
    
    
    init( ) {
        fetchChat()
    }
    
    func fetchChat() {
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
                    
                    self.chat.append(data!)
                
                }
            print(self.chat)
            
        }
    }
}
