//
//  RegisterViewController.swift
//  Chat Application
//
//  Created by Sahid Reza on 30/12/22.
//

import UIKit
import Toast
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var emailIdView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailIdTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.layer.cornerRadius = 6
        emailIdView.layer.cornerRadius = 6
        passwordView.layer.cornerRadius = 6
       
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountPress(_ sender: UIButton) {
        if (userNameTextField.text?.isEmpty)!{
            
            self.view.makeToast(K.validaionMessage, duration: 3.0, position: .bottom)
            
        }
        else if (emailIdTextField.text?.isEmpty)!{
            
            self.view.makeToast(K.validaionMessage, duration: 3.0, position: .bottom)
        }
        else if(passwordTextField.text?.isEmpty)! {
            
            self.view.makeToast(K.validaionMessage, duration: 3.0, position: .bottom)
            
        }else{
            
            if let emaildAdress = emailIdTextField.text,let password = passwordTextField.text,let userNameDisplay = userNameTextField.text {
                
                Auth.auth().createUser(withEmail: emaildAdress, password: password) { authResult, error in
                    
                    if error != nil{
                        
                        self.view.makeToast(error!.localizedDescription, duration: 3.0, position: .bottom)
                    }
                    
                    // Create new User
                    
                    else{
                        
                        let chageRequest = authResult?.user.createProfileChangeRequest()
                        chageRequest?.displayName = userNameDisplay
                        chageRequest?.commitChanges {(error) in
                            
                            if error != nil {
                                
                                self.view.makeToast(error!.localizedDescription, duration: 3.0, position: .bottom)
                            }
                            else{
                                
                                self.performSegue(withIdentifier: K.StoryBoardSegue.registerToChat, sender: self)
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
        
        
    }
    
}
