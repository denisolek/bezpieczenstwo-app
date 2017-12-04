//
//  ViewController.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SimpleKeychain
import AES256CBC

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var touchIdSwitch: UISwitch!
    
    @IBAction func loginOnClick(_: Any) {
        getToken(touchId: false)
    }

    @IBAction func touchIdOnClick(_: Any) {
        let keychain = A0SimpleKeychain()
        let secret = keychain.string(forKey: "user-secret")!
        usernameField.text = A0SimpleKeychain().string(forKey: "user-login")!.decrypt(_password: secret)
        passwordField.text = A0SimpleKeychain().string(forKey: "user-password")!.decrypt(_password: secret)
        getToken(touchId: true)
    }
    
    var jsonUsername = String()
    var jsonMessage = String()
    var jsonMessageDate = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is AccountViewController) {
            let accountVC = segue.destination as! AccountViewController
            accountVC.username = jsonUsername
            accountVC.message = jsonMessage.decrypt(_password: passwordField.text!)
            accountVC.messageDate = jsonMessageDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getToken(touchId: Bool) {
        let GET_TOKEN_URL = "https://bsm.denisolek.com/oauth/token?grant_type=password"
        let GET_TOKEN_PARAMS = [
            "username": usernameField.text!,
            "password": passwordField.text!,
        ]
        let GET_TOKEN_HEADERS = [
            "Authorization": "Basic YmV6cGllY3plbnN0d286ZGVwbG95dG9wc2VjcmV0",
        ]

        Alamofire.request(GET_TOKEN_URL,
                          method: .post,
                          parameters: GET_TOKEN_PARAMS,
                          encoding: URLEncoding.default,
                          headers: GET_TOKEN_HEADERS).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if(self.touchIdSwitch.isOn && !touchId) {
                        let secret = AES256CBC.generatePassword()
                        A0SimpleKeychain().setString(self.usernameField.text!.encrypt(_password: secret), forKey:"user-login")
                        A0SimpleKeychain().setString(self.passwordField.text!.encrypt(_password: secret), forKey:"user-password")
                        let keychain = A0SimpleKeychain()
                        keychain.useAccessControl = true
                        keychain.defaultAccessiblity = .whenPasscodeSetThisDeviceOnly
                        keychain.setString(secret, forKey:"user-secret")
                        print("touch id password SET")
                    }
                    let json = JSON(data: response.data!)
                    user.setAccessToken(_accessToken: json["access_token"].string!)
                    self.getUserData()
                case 400:
                    self.showAlertOK(_title: "Error", _message: "Invalid username or password")
                case 401:
                    self.showAlertOK(_title: "Error", _message: "Invalid username or password")
                default:
                    debugPrint(response)
                    self.showAlertOK(_title: "Ups!", _message: "Something went wrong")
                    print("error with response status: \(status)")
                }
            }
        }
    }
    
    func getUserData() {
        let AUTHORIZATION_HEADER = [
            "Authorization": "Bearer " + user.getAccessToken(),
            ]
        let GET_USER_URL = "https://bsm.denisolek.com/api/users"
        Alamofire.request(GET_USER_URL,
                          headers: AUTHORIZATION_HEADER).responseJSON { response in
                            if let status = response.response?.statusCode {
                                switch status {
                                case 200:
                                    let json = JSON(data: response.data!)
                                    print(json)
                                    self.jsonUsername = json["username"].string!
                                    self.jsonMessage = json["message"].string!
                                    self.jsonMessageDate = json["messageDate"].string!
                                    self.performSegue(withIdentifier: "loginSegue", sender: self)
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
