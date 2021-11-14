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
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            msgCardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            msgCardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            
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
        let messageLabel = PaddingLabel(withInsets: 1, 1, 5, 5)
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.textColor = .label
        messageLabel.textAlignment = .left
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
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
