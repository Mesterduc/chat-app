//
//  LoginController.swift
//  chat app
//
//  Created by Duc hong cai on 13/11/2021.
//

import UIKit
import FirebaseFirestore

class LoginController: UIViewController {
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let docRef = db.collection("hej").document("hej2")

        docRef.getDocument { (document, error) in
//            print(document)
            if let document = document, document.exists {
                let dataDescription = document.data()
                print("Document data: \(dataDescription!.values)")
            } else {
                print("Document does not exist")
            }
        }
    }


}
