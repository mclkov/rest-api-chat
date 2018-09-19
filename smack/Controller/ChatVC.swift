//
//  ChatVC.swift
//  smack
//
//  Created by McL on 8/19/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class ChatVC:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{

    // Outlets
    @IBOutlet weak var messageTV: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    // Variables
    var isWriting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        self.setupView()
        
        sendMessageBtn.isHidden = true
        
        messageTV.estimatedRowHeight = 80
        messageTV.rowHeight = UITableViewAutomaticDimension
        messageTV.dataSource = self
        messageTV.delegate = self
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        sendMessageBtn.addTarget(self, action: #selector(self.sendMessagePressed), for: .touchUpInside)
        messageTxt.addTarget(self, action: #selector(self.messageWriting), for: .editingChanged)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIFICATION_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn
        {
            SocketService.instance.getChatMessage(completion: { (success) in
                if success
                {
                    self.messageTV.reloadData()
                    if MessageService.instance.messages.count > 0
                    {
                        let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                        self.messageTV.scrollToRow(at: endIndex, at: .bottom, animated: false)
                    }
                }
            })
            
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
            })
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func messageWriting()
    {
        if messageTxt.text == ""
        {
            isWriting = false
            sendMessageBtn.isHidden = true
        }else{
            if isWriting == false
            {
                sendMessageBtn.isHidden = false
            }
            isWriting = true
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification)
    {
//        setupUserInfo()
        if AuthService.instance.isLoggedIn
        {
            // get channels
            onLoginGetMessages()
        }else{
            messageTV.reloadData()
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
            if success
            {
                self.messageTV.reloadData()
            }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messageTV.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell
        {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(messageArray: message)
            return cell
        }else{
            return MessageCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
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
