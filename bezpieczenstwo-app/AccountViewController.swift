//
//  AccountViewController.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AccountViewController: UIViewController {

    @IBAction func logoutOnClick(_: Any) {}
    @IBAction func changePasswordOnClick(_: Any) {
        performSegue(withIdentifier: "accountPasswordSegue", sender: self)
    }
    @IBAction func changeMessageOnClick(_ sender: Any) {
        performSegue(withIdentifier: "accountMessageSegue", sender: self)
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    var username = String()
    var message = String()
    var messageDate = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ChangePasswordViewController) {
            let passwordVC = segue.destination as! ChangePasswordViewController
            passwordVC.currentMessage = messageLabel.text!
        } else if (segue.destination is ChangeMessageViewController) {
            let messageVC = segue.destination as! ChangeMessageViewController
            messageVC.currentMessage = messageLabel.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        usernameLabel.text = username
        messageLabel.text = message
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
