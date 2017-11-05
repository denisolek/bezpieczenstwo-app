//
//  Exceptions.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 05/11/2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import Foundation

enum ServiceExceptions: Error {
    case none
    case isNotFound
    case isUnauthorized
    case isForbidden
}
