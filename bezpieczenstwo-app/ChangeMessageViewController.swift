//
//  ChangeMessageViewController.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 14/11/2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangeMessageViewController: UIViewController {
    @IBAction func saveButton(_ sender: Any) {
        updateUserData()
    }
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var passwordField: UITextField!

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
    
    var currentMessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        messageTextView.text = currentMessage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_: Bool) {
        if user.getAccessToken().isEmpty {
            invalidTokenAlert()
        }
    }
    
    func updateUserData() {
        let AUTHORIZATION_HEADER = [
            "Authorization": "Bearer " + user.getAccessToken(),
            ]
        let UPDATE_USER_URL = "https://bsm.denisolek.com/api/users"
        let UPDATE_USER_PARAMS: Parameters = [
            "content": messageTextView.text!.encrypt(_password: passwordField.text!),
            "password": passwordField.text!
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
                                    self.showAlertInfo(_title: "Message updated to:", _message: json["message"].string!.decrypt(_password: self.passwordField.text!))
                                    self.getUserData()
                                case 400:
                                    self.showAlertOK(_title: "Bad request", _message: "Message/password is empty or incorrect password")
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
                                    let when = DispatchTime.now() + 3
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        self.performSegue(withIdentifier: "messageLoginSegue", sender: self)
                                    }
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
