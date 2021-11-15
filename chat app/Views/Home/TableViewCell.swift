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
        
        contentView.addSubview(msgCardView)
        msgCardView.addSubview(user)
        msgCardView.addSubview(message)
        msgCardView.addSubview(timestamp)
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            msgCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            msgCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            msgCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            msgCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -5),
            user.centerXAnchor.constraint(equalTo: msgCardView.centerXAnchor),
            user.topAnchor.constraint(equalTo: msgCardView.topAnchor),
            timestamp.leadingAnchor.constraint(equalTo: user.trailingAnchor),
            
        ])
    }
    
     let msgCardView: UIView = {
      let view = UIView()
        view.layer.cornerRadius = 10
         view.layer.borderColor = CGColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.45)
         view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let message: UILabel = {
        let messageLabel = PaddingLabel(withInsets: 0, 0, 5, 5)
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.textColor = .label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    let timestamp: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        timeLabel.textColor = .label
        timeLabel.isHidden = true
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
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
