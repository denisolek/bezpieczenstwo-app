//
//  RegisterViewController.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordAgainField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func createUserOnClick(_: Any) {
        if passwordField.text == passwordAgainField.text {
            createUser()
        } else {
            showAlertOK(_title: "Validation error", _message: "Passwords are not equal!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        backButton.setupBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createUser() {
        let CREATE_USER_URL = "http://bsm.denisolek.com/api/users"
        let CREATE_USER_PARAMS: Parameters = [
            "username": usernameField.text!,
            "password": passwordField.text!,
            "message": messageField.text!,
        ]
        Alamofire.request(CREATE_USER_URL,
                          method: .post,
                          parameters: CREATE_USER_PARAMS,
                          encoding: JSONEncoding.default).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 201:
                    self.userCreatedAlert()
                case 400:
                    self.showAlertOK(_title: "Bad request", _message: "Password requires 8-50 length and at least one of each: a-Z, 1-9 and secret message can't be empty")
                case 409:
                    self.showAlertOK(_title: "Conflict", _message: "Username already exists")
                default:
                    debugPrint(response)
                    self.showAlertOK(_title: "Ups!", _message: "Something went wrong")
                    print("error with response status: \(status)")
                }
            }
        }
    }
}
