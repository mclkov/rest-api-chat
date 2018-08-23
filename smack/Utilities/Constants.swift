//
//  Constants.swift
//  smack
//
//  Created by McL on 8/20/18.
//  Copyright © 2018 McL. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://chatappo.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

// Segues
let LOGIN_VC = "login_vc"
let REGISTRATION_VC = "registration_vc"
let UNWIND = "unwind_to_channel_vc"

// User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
