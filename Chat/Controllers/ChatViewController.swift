//
//  ChatViewController.swift
//  Chat
//
//  Created by Alla Golovinova on 02.10.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        title = K.appName
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. ", e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data =  doc.data()
                            if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String, let username = data[K.FStore.name] as? String {
                                let newMessages = Message(sender: sender, body: messageBody, userName: username)
                                self.messages.append(newMessages)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        
        var username = String()
        if let messageBody = self.messageTextfield.text, let messageSender = Auth.auth().currentUser?.uid {
            
            db.collection(K.FStore.collectionUserNames).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if messageSender == data["uid"] as? String {
                            if let name = data["name"] as? String {
                                username = String(name)
                            }
                        }
                    }
                    self.db.collection(K.FStore.collectionName).addDocument(data: [
                        K.FStore.senderField: messageSender,
                        K.FStore.bodyField: messageBody,
                        K.FStore.dateField: Date().timeIntervalSince1970,
                        K.FStore.name: username
                    ]
                    ) { (error) in
                        if let e = error {
                            print("There was an issue saving data to firestore. ", e)
                        } else {
                            print("Successfully saved data")
                            DispatchQueue.main.async {
                                self.messageTextfield.text = ""
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //Set first letter of Username (if exist) in "MeAvatar" and "YouAvatar" icons
        if message.userName.count > 0 {
            let firstCharIndex = message.userName.index(message.userName.startIndex, offsetBy: 1)
            let firstChar = String(message.userName[..<firstCharIndex])
            cell.rightNameLabel.text = firstChar
            cell.leftNameLabel.text = firstChar
        } else {
            cell.rightNameLabel.text = ""
            cell.leftNameLabel.text = ""
        }
        
        //This is a message from current user
        if message.sender == Auth.auth().currentUser?.uid {
            cell.leftViewWithImage.isHidden = true
            cell.rightViewWithImage.isHidden = false
            
            cell.rightSpaceView.isHidden = true
            cell.leftSpaceView.isHidden = false
            
            cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPink)
            cell.label.textColor = UIColor(named: K.BrandColors.textColor)
        }
        //This is a message from another user
        else {
            cell.leftViewWithImage.isHidden = false
            cell.rightViewWithImage.isHidden = true

            cell.rightSpaceView.isHidden = false
            cell.leftSpaceView.isHidden = true
            
            cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.lightGray)
            cell.label.textColor = UIColor(named: K.BrandColors.textColor)
        }
        
        return cell
    }
}


