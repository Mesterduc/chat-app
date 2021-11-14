//
//  TableViewCell.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    static var identifier: String = "Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor  = .white
        
        contentView.addSubview(user)
        contentView.addSubview(message)
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            // insert constraints
            user.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            user.topAnchor.constraint(equalTo: contentView.topAnchor),
            message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            message.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            message.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            
        ])
    }
    
    let message: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.textColor = .label
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        messageLabel.backgroundColor = .gray
        return messageLabel
    }()
    
    let user: UILabel = {
        let userLabel = UILabel()
        userLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        userLabel.textColor = .label
        userLabel.textAlignment = .left
        userLabel.isHidden = true
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        return userLabel
    }()
    
}
