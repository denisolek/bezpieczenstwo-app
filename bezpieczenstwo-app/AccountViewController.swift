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

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(user.getAccessToken().isEmpty) {
            self.invalidTokenAlert()
        }
        getUserData()
    }
    
    func getUserData() {
        let GET_USER_URL = "http://bsm.denisolek.com/api/users"
        let GET_USER_HEADERS = [
            "Authorization": "Bearer " + user.getAccessToken(),
            ]

        Alamofire.request(GET_USER_URL,
                          headers: GET_USER_HEADERS).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    let json = JSON(data: response.data!)
                    self.usernameLabel.text = json["username"].string!
                    self.messageLabel.text = json["message"].string!
                case 401:
                    self.invalidTokenAlert()
                default:
                    print("error with response status: \(status)")
                }
            }
        }
    }
}
