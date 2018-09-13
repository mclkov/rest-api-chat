//
//  AddChannelVC.swift
//  smack
//
//  Created by McL on 9/12/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var createChannelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        // Do any additional setup after loading the view.
        closeButton.addTarget(self, action: #selector(self.closeButtonPressed), for: .touchUpInside)
        createChannelButton.addTarget(self, action: #selector(self.createChannelPressed), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func createChannelPressed()
    {
        guard let channelName = nameField.text, nameField.text != "" else
        {
            return
        }
        
        guard let channelDescription = descriptionField.text else
        {
            return
        }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success
            {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func closeButtonPressed()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setPlaceholderPurple(object: UITextField, placeholder: String)
    {
        object.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: PurplePlaceholder])
    }
    
    func setupView()
    {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        self.setPlaceholderPurple(object: nameField, placeholder: "name")
        self.setPlaceholderPurple(object: descriptionField, placeholder: "description")
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer)
    {
        dismiss(animated: true, completion: nil)
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
