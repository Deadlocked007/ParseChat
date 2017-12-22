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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSend(_ sender: Any) {
        guard let text = chatField.text, !text.isEmpty else {
            return
        }
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = text
        
        chatMessage.saveInBackground { (true, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        
        return cell
    }

}
