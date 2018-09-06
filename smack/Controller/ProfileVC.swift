//
//  ProfileVC.swift
//  smack
//
//  Created by McL on 9/6/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    @IBOutlet weak var closeModalButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        // Do any additional setup after loading the view.
        closeModalButton.addTarget(self, action: #selector(ProfileVC.closeModalPressed), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(ProfileVC.logoutPressed), for: .touchUpInside)
    }

    @objc func closeModalPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func logoutPressed()
    {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView()
    {
        userName.text = UserDataService.instance.avatarName
        userEmail.text = UserDataService.instance.email
        userAvatar.image = UIImage(named: UserDataService.instance.avatarName)
        userAvatar.backgroundColor = UserDataService.instance.returnUIColor()
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UIGestureRecognizer)
    {
        dismiss(animated: true, completion: nil)
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
