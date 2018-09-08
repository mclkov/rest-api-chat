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
        guard let login = loginTxt.text, loginTxt.text != "" else
        {
            return
        }
        guard let password = passwordTxt.text, passwordTxt.text != "" else
        {
            return
        }
        
        AuthService.instance.loginUser(email: login, password: password) { (success) in
            if success {
                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success
                    {
                        print(UserDataService.instance.name, UserDataService.instance.avatarName)
                        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
                        self.dismiss(animated: true, completion: nil)
//                        self.performSegue(withIdentifier: UNWIND, sender: nil)
                    }
                })
            }
        }
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
