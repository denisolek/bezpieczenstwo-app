//
//  User.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 05/11/2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import Foundation

class User {
    var accessToken: String = ""
    func getAccessToken() -> String {
        return accessToken
    }

    func setAccessToken(_accessToken: String) {
        accessToken = _accessToken
    }
}

var user: User = User()
