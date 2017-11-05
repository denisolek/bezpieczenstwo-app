//
//  Requests.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 05/11/2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Requests {
    
//    func getToken() throws -> String {
//        let GET_TOKEN_URL = "http://bsm.denisolek.com/oauth/token?grant_type=password"
//        let GET_TOKEN_PARAMS = [
//            "username": "test2",
//            "password": "test12345"
//            ]
//        let GET_TOKEN_HEADERS = [
//            "Authorization": "Basic YmV6cGllY3plbnN0d286ZGVwbG95dG9wc2VjcmV0",
//            ]
//        
////        var exception: ServiceExceptions = ServiceExceptions.none
//        
////        print(exception)
//        
//
//        
//        Alamofire.request(GET_TOKEN_URL,
//                          method: .post,
//                          parameters: GET_TOKEN_PARAMS,
//                          encoding: URLEncoding.default,
//                          headers: GET_TOKEN_HEADERS).responseJSON { response in
////                            debugPrint(response)
//                            if let status = response.response?.statusCode {
//                                switch(status){
//                                case 200:
//                                    let json = JSON(data: response.data!)
//                                    print(json["access_token"])
//                                    myGroup.leave()
//                                case 401:
//                                    print("Bad credentials")
////                                    exception = ServiceExceptions.isUnauthorized
//                                default:
//                                    print("error with response status: \(status)")
//                                }
//                            }
//        }
//
//        return "test"
////        myGroup.notify(queue: DispatchQueue.main, execute: {
////            print("JUZ PO")
////            throw exception
////            return "test"
////        })
//    }
}

var httpRequest: Requests = Requests()
