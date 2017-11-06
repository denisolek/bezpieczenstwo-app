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
    
    @IBAction func saveOnClick(_ sender: Any) {
        updateUserData()
    }
    @IBAction func logoutOnClick(_ sender: Any) {
    }

    @IBAction func changePasswordOnClick(_ sender: Any) {
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
    
    let AUTHORIZATION_HEADER = [
        "Authorization": "Bearer " + user.getAccessToken(),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_: Bool) {
        if user.getAccessToken().isEmpty {
            invalidTokenAlert()
        }
        getUserData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.usernameLabel.text = ""
        self.messageLabel.text = ""
    }

    func getUserData() {
        let GET_USER_URL = "http://bsm.denisolek.com/api/users"
        Alamofire.request(GET_USER_URL,
                          headers: AUTHORIZATION_HEADER).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    let json = JSON(data: response.data!)
                    self.usernameLabel.text = json["username"].string!
                    self.messageLabel.text = json["message"].string!
                case 401:
                    self.invalidTokenAlert()
                default:
                    debugPrint(response)
                    self.showAlertOK(_title: "Ups!", _message: "Something went wrong")
                    print("error with response status: \(status)")
                }
            }
        }
    }
    
    func updateUserData() {
        let UPDATE_USER_URL = "http://bsm.denisolek.com/api/users"
        let UPDATE_USER_PARAMS: Parameters = [
            "content": messageLabel.text!
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
                                    self.getUserData()
                                case 401:
                                    self.invalidTokenAlert()
                                default:
                                    debugPrint(response)
                                    self.showAlertOK(_title: "Ups!", _message: "Something went wrong")
                                    print("error with response status: \(status)")
                                    self.getUserData()
                                }
                            }
        }
    }
    
}
