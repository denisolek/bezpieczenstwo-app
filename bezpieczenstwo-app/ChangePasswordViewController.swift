//
//  ChangePasswordViewController.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var newPasswordAgainField: UITextField!
    @IBAction func updatePasswordOnClick(_: Any) {
        if newPasswordField.text == newPasswordAgainField.text {
            updatePassword()
        } else {
            showAlertOK(_title: "Validation error", _message: "New passwords are not equal!")
        }
    }

    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        backButton.setupBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updatePassword() {
        let CHANGE_PASSWORD_URL = "http://bsm.denisolek.com/api/users/change-password"
        let CHANGE_PASSWORD_PARAMS: Parameters = [
            "oldPassword": oldPasswordField.text!,
            "newPassword": newPasswordField.text!,
        ]
        let AUTHORIZATION_HEADER = [
            "Authorization": "Bearer " + user.getAccessToken(),
        ]
        Alamofire.request(CHANGE_PASSWORD_URL,
                          method: .put,
                          parameters: CHANGE_PASSWORD_PARAMS,
                          encoding: JSONEncoding.default,
                          headers: AUTHORIZATION_HEADER).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    self.showAlertOK(_title: "OK", _message: "Password changed!")
                case 400:
                    self.showAlertOK(_title: "Bad request", _message: "Old password doesnt match or wrong new password format (password requires 8-50 length and at least one of each: a-Z, 1-9")
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
}
