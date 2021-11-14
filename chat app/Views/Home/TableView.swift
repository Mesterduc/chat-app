//
//  TableView.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.chat.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.user.isHidden = !cell.user.isHidden
            cell.backgroundColor = .none
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
     
        cell.user.text = self.vm.chat[indexPath.row].user
        cell.message.text = self.vm.chat[indexPath.row].message
        
        if (self.vm.chat[indexPath.row].user == self.activeUser) {
            cell.msgCardView.backgroundColor = .systemBlue
            cell.message.textAlignment = .right
            NSLayoutConstraint.activate([
                cell.msgCardView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
                cell.user.trailingAnchor.constraint(equalTo: cell.msgCardView.trailingAnchor, constant: -10),
                cell.user.topAnchor.constraint(equalTo: cell.msgCardView.topAnchor),
                cell.message.trailingAnchor.constraint(equalTo: cell.msgCardView.trailingAnchor, constant: -10),
                cell.message.widthAnchor.constraint(equalTo: cell.msgCardView.widthAnchor),
                cell.message.heightAnchor.constraint(equalTo: cell.msgCardView.heightAnchor),
            ])
        }else {
            cell.msgCardView.backgroundColor = .gray
            NSLayoutConstraint.activate([
                cell.msgCardView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
                cell.user.leadingAnchor.constraint(equalTo: cell.msgCardView.leadingAnchor, constant: 10),
                cell.user.topAnchor.constraint(equalTo: cell.msgCardView.topAnchor),
                cell.message.leadingAnchor.constraint(equalTo: cell.msgCardView.leadingAnchor, constant: 10),
                cell.message.widthAnchor.constraint(equalTo: cell.msgCardView.widthAnchor),
                cell.message.heightAnchor.constraint(equalTo: cell.msgCardView.heightAnchor),
            ])
        }
        
        
        NSLayoutConstraint.activate([

        ])
        return cell
    }
    
    
    
}
