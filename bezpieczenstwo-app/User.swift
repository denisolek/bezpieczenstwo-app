//
//  User.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 05/11/2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import Foundation

class User {
    var username: String = ""
    var message: String = ""
    var messageDate: String = ""
    var accessToken: String = ""

    func getUsername() -> String {
        return username
    }

    func setUsername(_username: String) {
        username = _username
    }

    func getMessage() -> String {
        return message
    }

    func setMessage(_message: String) {
        message = _message
    }

    func getAccessToken() -> String {
        return accessToken
    }

    func setAccessToken(_accessToken: String) {
        accessToken = _accessToken
    }
}

var user: User = User()
