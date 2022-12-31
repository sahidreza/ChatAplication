//
//  ChatViewController.swift
//  Chat Application
//
//  Created by Sahid Reza on 30/12/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var messageTypingTextField: UITextField!
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    let db = Firestore.firestore()
    
    
    var messages: [UserMessageData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        messageTypingTextField.layer.cornerRadius = messageTypingTextField.frame.height / 8
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: K.nibMessageName, bundle: nil), forCellReuseIdentifier: K.messageReusableCell)
        getMessageData()
    }
    
    func getMessageData(){
        
        db.collection(K.FirebaseDetails.firebase_tableName).order(by: K.FirebaseDetails.firbase_messageTime).addSnapshotListener{ (querySnapshot, err) in
            
            self.messages = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                if let snapshortDocument = querySnapshot?.documents{
                    for doc in snapshortDocument{
                        
                        let data = doc.data()
                        
                        if let displalyName = data[K.FirebaseDetails.firebase_userDisplayName] as? String, let emaildId = data[K.FirebaseDetails.firebase_emilID] as? String,let messageBody = data[K.FirebaseDetails.firebase_messageBody] as?String{
                            let userMessageDta = UserMessageData(sender: emaildId, body: messageBody, displayName: displalyName)
                            self.messages.append(userMessageDta)
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                               
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
        }
        
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if messageTypingTextField.text != "" , let userMessage = messageTypingTextField.text,let sender = Auth.auth().currentUser?.email, let userDisplayName = Auth.auth().currentUser?.displayName {
            
            db.collection(K.FirebaseDetails.firebase_tableName).addDocument(data: [K.FirebaseDetails.firebase_messageBody: userMessage,K.FirebaseDetails.firebase_emilID:sender,K.FirebaseDetails.firebase_userDisplayName:userDisplayName,K.FirebaseDetails.firbase_messageTime:Date().timeIntervalSince1970]) { err in
                if let error = err {
                    print("Error adding document: \(error)")
                    
                }else{
                    DispatchQueue.main.async {
                        self.messageTypingTextField.text = ""
                    }
                }
                
            }
            
        }
        
    }
    
    
    
    @IBAction func logOutPressee(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        
        
    }
    
}

// MARK: - Using UITableview Data Source

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageReusableCell, for: indexPath) as! ChatTableViewCell
        cell.messageLabel.text = messages[indexPath.row].body
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email{
            
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.perperC0lour)
            cell.messageLabel.textColor = .white
            
        }
        else{
            
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: K.assColour)
            cell.messageLabel.textColor = .black
            
        }
        
        return cell
    }
    
    
}
