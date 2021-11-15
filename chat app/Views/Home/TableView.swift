//
//  TableView.swift
//  chat app
//
//  Created by Duc hong cai on 14/11/2021.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.chat.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.user.isHidden = !cell.user.isHidden
            cell.timestamp.isHidden = !cell.timestamp.isHidden
            cell.backgroundColor = .none
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let chatData = self.vm.chat[indexPath.row]
        
        cell.user.text = chatData.user
        cell.message.text = chatData.message
        let formatter = DateFormatter()
        formatter.dateFormat = "  dd.MM.yyyy  HH:mm"
        cell.timestamp.text = formatter.string(from: chatData.timestamp)
        
        if (chatData.user == self.activeUser) {
            cell.msgCardView.backgroundColor = .systemBlue
            cell.message.textAlignment = .right
            NSLayoutConstraint.activate([
                cell.message.trailingAnchor.constraint(equalTo: cell.msgCardView.trailingAnchor),
                cell.message.widthAnchor.constraint(equalTo: cell.msgCardView.widthAnchor),
                cell.message.heightAnchor.constraint(equalTo: cell.msgCardView.heightAnchor),
            ])
        }else {
            cell.msgCardView.backgroundColor = .gray
            cell.message.textAlignment = .left
            NSLayoutConstraint.activate([
                cell.message.leadingAnchor.constraint(equalTo: cell.msgCardView.leadingAnchor),
                cell.message.widthAnchor.constraint(equalTo: cell.msgCardView.widthAnchor),
                cell.message.heightAnchor.constraint(equalTo: cell.msgCardView.heightAnchor),
            ])
        }
        return cell
    }
    
    
    
}
