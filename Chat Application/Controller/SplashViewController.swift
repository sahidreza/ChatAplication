//
//  SplashViewController.swift
//  Chat Application
//
//  Created by Sahid Reza on 29/12/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var applicationNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationName = "🧑‍💻Techy Chat"
        applicationNameLabel.text = ""
        var timeIncreaseing = 1.0
        
        for i in applicationName{
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * timeIncreaseing, repeats: false) { timer in
                self.applicationNameLabel.text?.append(i)
                
            }
            timeIncreaseing += 1
        }
        
       
     
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    
    }
    
    
}

