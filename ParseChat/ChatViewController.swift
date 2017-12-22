//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Siraj Zaneer on 12/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 66
        
        tableView.tableFooterView = UIView()
        
        getMessages()
    }
    
    func getMessages() {
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1e9))) {
            let query = PFQuery(className: "Message")
            query.addAscendingOrder("createdAt")
            query.includeKey("user")
            
            query.findObjectsInBackground(block: { (messages, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.getMessages()
                } else if let messages = messages {
                    self.messages = messages
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                    self.getMessages()
                }
            })
        }
    }

    @IBAction func onSend(_ sender: Any) {
        guard let text = chatField.text, !text.isEmpty else {
            return
        }
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = text
        chatMessage["user"] = PFUser.current()!
        
        chatMessage.saveInBackground { (true, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.chatField.text = ""
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        
        
        cell.chatLabel.text = message["text"] as? String ?? ""
        cell.chatLabel.sizeToFit()
        
        return cell
    }

}
