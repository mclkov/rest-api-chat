//
//  ChatVC.swift
//  smack
//
//  Created by McL on 8/19/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        self.setupView()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        sendMessageBtn.addTarget(self, action: #selector(self.sendMessagePressed), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIFICATION_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn
        {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
            })
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func userDataDidChange(_ notif: Notification)
    {
//        setupUserInfo()
        if AuthService.instance.isLoggedIn
        {
            // get channels
            onLoginGetMessages()
        }else{
            channelNameLabel.text = "Please, Log In"
        }
    }
    
    @objc func channelSelected(_ notif: Notification)
    {
        updateWithChannel()
    }
    
    func updateWithChannel()
    {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        self.getMessages()
    }
    
    func onLoginGetMessages()
    {
        MessageService.instance.findAllChannels { (success) in
            if success
            {
                if MessageService.instance.channels.count > 0
                {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLabel.text = "No channels yet..."
                }
            }
        }
    }
    
    func getMessages()
    {
        guard let channelId = MessageService.instance.selectedChannel?.id else
        {
            return
        }
        MessageService.instance.findAllMessagesOfChannel(channelId: channelId) { (success) in
            
        }
    }

    @objc func sendMessagePressed()
    {
        if AuthService.instance.isLoggedIn
        {
            guard let channelId = MessageService.instance.selectedChannel?.id else
            {
                return
            }
            
            guard let message = messageTxt.text else
            {
                return
            }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success
                {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupView()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap()
    {
        view.endEditing(true)
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
