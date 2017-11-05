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

    @IBAction func loginOnClick(_ sender: Any) {
        print(getToken())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertHere(){
        self.showAlertOK(_title: "test", _message: "Message")
    }
    
    func getToken() -> String {
        let GET_TOKEN_URL = "http://bsm.denisolek.com/oauth/token?grant_type=password"
        let GET_TOKEN_PARAMS = [
            "username": "test2",
            "password": "test12345"
        ]
        let GET_TOKEN_HEADERS = [
            "Authorization": "Basic YmV6cGllY3plbnN0d286ZGVwbG95dG9wc2VjcmV0",
            ]
        
        //        var exception: ServiceExceptions = ServiceExceptions.none
        
        //        print(exception)
        
        
        
        Alamofire.request(GET_TOKEN_URL,
                          method: .post,
                          parameters: GET_TOKEN_PARAMS,
                          encoding: URLEncoding.default,
                          headers: GET_TOKEN_HEADERS).responseJSON { response in
                            //                            debugPrint(response)
                            if let status = response.response?.statusCode {
                                switch(status){
                                case 200:
                                    let json = JSON(data: response.data!)
                                    print(json["access_token"])
                                case 401:
                                    self.showAlertOK(_title: "test", _message: "Bad Credentials")
                                //                                    exception = ServiceExceptions.isUnauthorized
                                default:
                                    print("error with response status: \(status)")
                                }
                            }
        }
        
        return "test"
    }
}


