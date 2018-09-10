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
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

// Notification constants
let NOTIFICATION_USER_DATA_CHANGED = Notification.Name("notificationUserDataChanged")

// Colors
let PurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

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

let BEARER_HEADER =
[
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
