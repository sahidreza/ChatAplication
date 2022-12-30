//
//  LoginViewController.swift
//  Chat Application
//
//  Created by Sahid Reza on 30/12/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var emilIdTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.layer.cornerRadius = 6
        passwordView.layer.cornerRadius = 6
    }
    
    
    @IBAction func logInPress(_ sender: UIButton) {
        
        if (emilIdTextField.text?.isEmpty)!{
            
            self.view.makeToast(K.validaionMessage, duration: 3.0, position: .bottom)
            
        }
        else if (passwordTextField.text?.isEmpty)!{
            
            self.view.makeToast(K.validaionMessage, duration: 3.0, position: .bottom)
        }else {
            
            if let emailID = emilIdTextField.text,let password = passwordTextField.text{
                
                Auth.auth().signIn(withEmail: emailID, password: password) { authResult, error in
                    
                    if error != nil {
                        
                        self.view.makeToast(error!.localizedDescription, duration: 3.0, position: .bottom)
                    }else{
                        self.performSegue(withIdentifier: K.StoryBoardSegue.loginToChat, sender: self)
                    }
                    
                }
                
            }
            
            
            
        }
        
        
    }
}
