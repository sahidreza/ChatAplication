//
//  RegisterViewController.swift
//  Chat Application
//
//  Created by Sahid Reza on 30/12/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var emailIdView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.layer.cornerRadius = 6
        emailIdView.layer.cornerRadius = 6
        passwordView.layer.cornerRadius = 6

        // Do any additional setup after loading the view.
    }
    
    
}
