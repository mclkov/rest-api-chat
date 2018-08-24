//
//  RegistrationVC.swift
//  smack
//
//  Created by McL on 8/21/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    // Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var pickAvatarButton: UIButton!
    @IBOutlet weak var pickColorButton: UIButton!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        closeButton.addTarget(self, action: #selector(self.closePressed), for: .touchUpInside)
        
        pickAvatarButton.addTarget(self, action: #selector(self.pickAvatarPressed), for: .touchUpInside)
        pickColorButton.addTarget(self, action: #selector(self.pickColorPressed), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(self.createAccountPressed), for: .touchUpInside)
    }
    
    @objc func closePressed()
    {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @objc func pickAvatarPressed()
    {
        
    }
    
    @objc func pickColorPressed()
    {
        
    }
    
    @objc func createAccountPressed()
    {
        guard let email = emailTxt.text, emailTxt.text != "" else
        {
            return
        }
        
        guard let password = passwordTxt.text, passwordTxt.text != "" else
        {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success
                    {
                        print("logged in user", AuthService.instance.authToken)
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
