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
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"

// Segues
let LOGIN_VC = "login_vc"
let REGISTRATION_VC = "registration_vc"
let UNWIND = "unwind_to_channel_vc"
let TO_PICK_AVATAR = "to_pick_avatar"

// User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER =
[
    "Content-Type": "application/json; charset=utf-8"
]
