//
//  LoginVC.swift
//  smack
//
//  Created by McL on 8/20/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    @IBOutlet weak var loginTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        closeButton.addTarget(self, action: #selector(self.closePressed), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(self.registrationPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(self.loginPressed), for: .touchUpInside)
    }
    
    @objc func loginPressed()
    {
        
    }
    
    @objc func closePressed()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func registrationPressed()
    {
        performSegue(withIdentifier: REGISTRATION_VC, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
