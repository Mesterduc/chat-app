//
//  Chat.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Chat: Codable {
    @DocumentID var id: String?
    let message: String
    var timestamp: Date
    var user: String
    
}
