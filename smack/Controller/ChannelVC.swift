//
//  ChannelVC.swift
//  smack
//
//  Created by McL on 8/19/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var channelTV: UITableView!
    @IBOutlet weak var addChannelButton: UIButton!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelTV.delegate = self
        channelTV.dataSource = self

        addChannelButton.addTarget(self, action: #selector(self.addChannelPressed), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        loginBtn.addTarget(self, action: #selector(ChannelVC.loginButtonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUserInfo()
    }
    
    @objc func addChannelPressed()
    {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification)
    {
        self.setupUserInfo()
    }

    @objc func loginButtonPressed ()
    {
        if AuthService.instance.isLoggedIn
        {
            // Show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: LOGIN_VC, sender: nil)
        }
    }
    
    func setupUserInfo()
    {
        if AuthService.instance.isLoggedIn
        {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            avatarImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarImage.backgroundColor = UserDataService.instance.returnUIColor()
        } else {
            loginBtn.setTitle("Login", for: .normal)
            avatarImage.image = UIImage(named: "menuProfileIcon")
            avatarImage.backgroundColor = UIColor.clear
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = channelTV.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell
        {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MessageService.instance.channels.count
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
