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

    @IBAction func saveOnClick(_: Any) {
        updateUserData()
    }

    @IBAction func logoutOnClick(_: Any) {
    }

    @IBAction func changePasswordOnClick(_: Any) {
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!

    let AUTHORIZATION_HEADER = [
        "Authorization": "Bearer " + user.getAccessToken(),
    ]

    var username = String()
    var message = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        usernameLabel.text = username
        messageLabel.text = message
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_: Bool) {
        print(message)
//        if user.getAccessToken().isEmpty {
//            invalidTokenAlert()
//        }
//        getUserData()
    }

//    override func viewDidDisappear(_: Bool) {
//        usernameLabel.text = ""
//        messageLabel.text = ""
//    }

    func updateUserData() {
        let UPDATE_USER_URL = "http://bsm.denisolek.com/api/users"
        let UPDATE_USER_PARAMS: Parameters = [
            "content": messageLabel.text!,
        ]
        Alamofire.request(UPDATE_USER_URL,
                          method: .put,
                          parameters: UPDATE_USER_PARAMS,
                          encoding: JSONEncoding.default,
                          headers: AUTHORIZATION_HEADER).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    let json = JSON(data: response.data!)
                    self.showAlertOK(_title: "Message updated to:", _message: json["message"].string!)
                    self.messageLabel.text = json["message"].string!
                case 400:
                    self.showAlertOK(_title: "Bad request", _message: "Message can't be empty")
//                    self.getUserData()
                case 401:
                    self.invalidTokenAlert()
                default:
                    debugPrint(response)
                    self.showAlertOK(_title: "Ups!", _message: "Something went wrong")
                    print("error with response status: \(status)")
//                    self.getUserData()
                }
            }
        }
    }
}
