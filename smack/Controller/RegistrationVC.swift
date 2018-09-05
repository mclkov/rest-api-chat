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
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var pickAvatarButton: UIButton!
    @IBOutlet weak var pickColorButton: UIButton!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        
        closeButton.addTarget(self, action: #selector(self.closePressed), for: .touchUpInside)
        
        pickAvatarButton.addTarget(self, action: #selector(self.pickAvatarPressed), for: .touchUpInside)
        pickColorButton.addTarget(self, action: #selector(self.pickColorPressed), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(self.createAccountPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""
        {
            let currentAvatarName = UserDataService.instance.avatarName
            userImg.image = UIImage(named: currentAvatarName)
            avatarName = currentAvatarName
            
            if avatarName.contains("light") && bgColor == nil
            {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @objc func closePressed()
    {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @objc func pickAvatarPressed()
    {
        performSegue(withIdentifier: TO_PICK_AVATAR, sender: nil)
    }
    
    @objc func pickColorPressed()
    {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2)
        {
            self.userImg.backgroundColor = self.bgColor
        }
//        self.userImg.backgroundColor = bgColor
    }
    
    @objc func createAccountPressed()
    {
        loadingBar.isHidden = false
        loadingBar.startAnimating()
        guard let name = usernameTxt.text, usernameTxt.text != "" else
        {
            return
        }
        
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
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success
                            {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.loadingBar.isHidden = true
                                self.loadingBar.stopAnimating()
                                
                                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
                                
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
//                        print("logged in user", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    func setPlaceholderPurple(object: UITextField, placeholder: String)
    {
        object.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: PurplePlaceholder])
    }
    
    func setupView()
    {
        loadingBar.isHidden = true
        
        setPlaceholderPurple(object: usernameTxt, placeholder: "username")
        setPlaceholderPurple(object: emailTxt, placeholder: "email")
        setPlaceholderPurple(object: passwordTxt, placeholder: "password")
//        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: PurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap()
    {
        view.endEditing(true)
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
