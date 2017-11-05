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

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginOnClick(_: Any) {
        getToken()
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

    func getToken() {
        let GET_TOKEN_URL = "http://bsm.denisolek.com/oauth/token?grant_type=password"
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
//          debugPrint(response)
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    let json = JSON(data: response.data!)
                    print(json["access_token"])
                    user.setAccessToken(_accessToken: json["access_token"].string!)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let accountVC = storyBoard.instantiateViewController(withIdentifier: "accountView")
                    self.present(accountVC, animated: true, completion: nil)
                case 401:
                    self.showAlertOK(_title: "ERROR", _message: "Invalid username or password")
                default:
                    print("error with response status: \(status)")
                }
            }
        }
    }
}
