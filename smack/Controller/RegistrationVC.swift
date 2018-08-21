//
//  RegistrationVC.swift
//  smack
//
//  Created by McL on 8/21/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        closeButton.addTarget(self, action: #selector(self.closePressed), for: .touchUpInside)
    }

    
    @objc func closePressed()
    {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
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
